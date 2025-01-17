import 'dart:convert';
import "dart:html";

import "package:github/browser.dart";

import "common.dart";

DivElement readmeDiv;

Future<void> main() async {
  await initViewSourceButton("readme.dart");
  readmeDiv = querySelector("#readme");
  const repo = RepositorySlug("DirectMyFile", "github.dart");
  final readme = await github.repositories.getReadme(repo);
  String markdown = readme.content;
  if (readme.encoding == 'base64') {
    markdown = String.fromCharCodes(base64.decode(markdown));
  }
  print(markdown);
  final html = await github.misc.renderMarkdown(markdown);
  readmeDiv.appendHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
}
