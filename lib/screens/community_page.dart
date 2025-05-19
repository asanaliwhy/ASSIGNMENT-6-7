import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_2/Provider/community_provider.dart';
import 'package:final_2/error_handler.dart';
import 'package:final_2/generated/l10n.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showAddPostDialog() {
    bool isValid = false;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool canPost = _titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty;
            final localizations = AppLocalizations.of(context)!;

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                localizations.newPost,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: localizations.title,
                        hintText: localizations.enterPostTitle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isValid = value.isNotEmpty && _descriptionController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: localizations.text,
                        hintText: localizations.shareThoughts,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      maxLines: 4,
                      onChanged: (value) {
                        setState(() {
                          isValid = value.isNotEmpty && _titleController.text.isNotEmpty;
                        });
                      },
                    ),
                    if (!isValid && (_titleController.text.isEmpty || _descriptionController.text.isEmpty))
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          localizations.fillBothFields,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    localizations.cancel,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: canPost
                      ? () {
                    Provider.of<CommunityProvider>(context, listen: false).addPost(
                      _titleController.text,
                      _descriptionController.text,
                      'User',
                    );
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(localizations.post),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditPostDialog(int index, Map<String, dynamic> post) {
    _titleController.text = post['title'];
    _descriptionController.text = post['content'];
    bool isValid = true;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool canSave = _titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty;
            final localizations = AppLocalizations.of(context)!;

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                localizations.editPost,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: localizations.title,
                        hintText: localizations.enterPostTitle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isValid = value.isNotEmpty && _descriptionController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: localizations.description,
                        hintText: localizations.shareThoughts,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      maxLines: 4,
                      onChanged: (value) {
                        setState(() {
                          isValid = value.isNotEmpty && _titleController.text.isNotEmpty;
                        });
                      },
                    ),
                    if (!isValid && (_titleController.text.isEmpty || _descriptionController.text.isEmpty))
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          localizations.fillBothFields,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    localizations.cancel,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: canSave
                      ? () {
                    Provider.of<CommunityProvider>(context, listen: false).editPost(
                      index,
                      _titleController.text,
                      _descriptionController.text,
                    );
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(localizations.save),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeletePostDialog(int index) {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(localizations.deletePost),
        content: Text(localizations.confirmDeletePost),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel, style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Provider.of<CommunityProvider>(context, listen: false).deletePost(index);
              Navigator.pop(context);
            },
            child: Text(localizations.delete, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    print('Likes label: ${localizations.likes}'); // Debug print
    return Consumer<CommunityProvider>(
      builder: (context, provider, child) {
        if (provider.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ErrorHandler.showError(context, provider.errorMessage!);
            provider.clearError();
          });
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _showAddPostDialog,
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: localizations.searchPosts,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (value) => provider.setSearchQuery(value),
                    ),
                  ),
                  Expanded(
                    child: provider.filteredPosts.isEmpty && provider.searchQuery.isNotEmpty
                        ? Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          localizations.textNotFound,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.all(12.0),
                      itemCount: provider.filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = provider.filteredPosts[index];
                        final isUserPost = post['author'] == 'User';
                        final originalIndex = provider.posts.indexOf(post);
                        print('Likes value for post $index: ${post['likes'].runtimeType} - ${post['likes']}'); // Debug print
                        print('Available width: ${MediaQuery.of(context).size.width}'); // Debug print for width
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - _fadeAnimation.value)),
                              child: Opacity(
                                opacity: _fadeAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.deepPurple,
                                        child: Text(
                                          post['author'][0],
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post['author'],
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              post['timestamp'],
                                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isUserPost) ...[
                                        IconButton(
                                          icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                                          onPressed: () => _showEditPostDialog(originalIndex, post),
                                          constraints: BoxConstraints(maxWidth: 30),
                                          padding: EdgeInsets.zero,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                          onPressed: () => _showDeletePostDialog(originalIndex),
                                          constraints: BoxConstraints(maxWidth: 30),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    post['content'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () => provider.toggleLike(originalIndex),
                                        icon: Icon(
                                          post['likedByUser'] ? Icons.favorite : Icons.favorite_border,
                                          size: 20,
                                          color: post['likedByUser'] ? Colors.red : null,
                                        ),
                                        label: Text(
                                          '${post['likes'] as int? ?? 0} Likes', // Temporary hardcoded fallback
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}