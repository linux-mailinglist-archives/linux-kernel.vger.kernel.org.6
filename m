Return-Path: <linux-kernel+bounces-256947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF649372FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EDCB21083
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F037703;
	Fri, 19 Jul 2024 04:15:20 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4BB1CA9C;
	Fri, 19 Jul 2024 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721362519; cv=none; b=kvAXtzyCcU/mwuKL8jaiwz7Q/JZ4LwiJS5/7M62p1WlpJS+yqK1Muu1q0JhybAg6KVsRiy36D3a9FFYccFwM/bs27CCpRcPXR+Atr0nhgUKTQG0Yh24s50ExsXkiSrTCIDHYl2kAbY4WevM6hcdyT15nydJDSmj8KJGGdyXElU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721362519; c=relaxed/simple;
	bh=6Pov9ydxUCi6zoPvZB68QjCxberBXnnTl0s211O6YHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5zyCMmNJpksV/rAf43kZxxRkxe9wbg9sMWcyaJJ+FmBWRwVlYDo98j93uzQ6BY3I1zfkIdSeblZJRRM36BJAkZ6wSIG75ve8RydTFIk1/Sase2doIONEvNPR3uhlK4Bvrq+i/ESMjzvmUDFSP6ve8+PvnMq34c/DxN+HJqecdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAAHaG0c6JlmaGt4AQ--.44406S2;
	Fri, 19 Jul 2024 12:14:20 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAnhh4I6JlmCSoKAA--.20209S3;
	Fri, 19 Jul 2024 12:14:18 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: chengziqiu@hust.edu.cn,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] scripts: fix all issues reported by pylint
Date: Fri, 19 Jul 2024 12:13:33 +0800
Message-ID: <20240719041400.3909775-2-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719041400.3909775-1-dzm91@hust.edu.cn>
References: <20240719041400.3909775-1-dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAAHaG0c6JlmaGt4AQ--.44406S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3CF4UJry5JrWfKFykWr4rXwb_yoWkJF1kpa
	4rGF4xArW5JFWjyrn7Jw4UuFy3Ar97JrWUXry2vr97ArnrKasY9F42k34SvrZ7WF1fXaya
	qFWYkryYvr1UuaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26F
	4j6r4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUqb4SDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

This patch 1) fixes all the issues (not most) reported by pylint,
2) add the functionability to tackle documents that need translation,
3) add logging to adjust the logging level and log file

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 scripts/checktransupdate.py | 214 ++++++++++++++++++++++++------------
 1 file changed, 141 insertions(+), 73 deletions(-)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index 5a0fc99e3f93..578c3fecfdfd 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -10,31 +10,28 @@ differences occur, report the file and commits that need to be updated.
 
 The usage is as follows:
 - ./scripts/checktransupdate.py -l zh_CN
-This will print all the files that need to be updated in the zh_CN locale.
+This will print all the files that need to be updated or translated in the zh_CN locale.
 - ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 This will only print the status of the specified file.
 
 The output is something like:
-Documentation/translations/zh_CN/dev-tools/testing-overview.rst (1 commits)
+Documentation/dev-tools/kfence.rst
+No translation in the locale of zh_CN
+
+Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
+1 commits needs resolving in total
 """
 
 import os
-from argparse import ArgumentParser, BooleanOptionalAction
+import time
+import logging
+from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
 from datetime import datetime
 
-flag_p_c = False
-flag_p_uf = False
-flag_debug = False
-
-
-def dprint(*args, **kwargs):
-    if flag_debug:
-        print("[DEBUG] ", end="")
-        print(*args, **kwargs)
-
 
 def get_origin_path(file_path):
+    """Get the origin path from the translation path"""
     paths = file_path.split("/")
     tidx = paths.index("translations")
     opaths = paths[:tidx]
@@ -43,17 +40,16 @@ def get_origin_path(file_path):
 
 
 def get_latest_commit_from(file_path, commit):
-    command = "git log --pretty=format:%H%n%aD%n%cD%n%n%B {} -1 -- {}".format(
-        commit, file_path
-    )
-    dprint(command)
+    """Get the latest commit from the specified commit for the specified file"""
+    command = f"git log --pretty=format:%H%n%aD%n%cD%n%n%B {commit} -1 -- {file_path}"
+    logging.debug(command)
     pipe = os.popen(command)
     result = pipe.read()
     result = result.split("\n")
     if len(result) <= 1:
         return None
 
-    dprint("Result: {}".format(result[0]))
+    logging.debug("Result: %s", result[0])
 
     return {
         "hash": result[0],
@@ -64,17 +60,19 @@ def get_latest_commit_from(file_path, commit):
 
 
 def get_origin_from_trans(origin_path, t_from_head):
+    """Get the latest origin commit from the translation commit"""
     o_from_t = get_latest_commit_from(origin_path, t_from_head["hash"])
     while o_from_t is not None and o_from_t["author_date"] > t_from_head["author_date"]:
         o_from_t = get_latest_commit_from(origin_path, o_from_t["hash"] + "^")
     if o_from_t is not None:
-        dprint("tracked origin commit id: {}".format(o_from_t["hash"]))
+        logging.debug("tracked origin commit id: %s", o_from_t["hash"])
     return o_from_t
 
 
 def get_commits_count_between(opath, commit1, commit2):
-    command = "git log --pretty=format:%H {}...{} -- {}".format(commit1, commit2, opath)
-    dprint(command)
+    """Get the commits count between two commits for the specified file"""
+    command = f"git log --pretty=format:%H {commit1}...{commit2} -- {opath}"
+    logging.debug(command)
     pipe = os.popen(command)
     result = pipe.read().split("\n")
     # filter out empty lines
@@ -83,50 +81,120 @@ def get_commits_count_between(opath, commit1, commit2):
 
 
 def pretty_output(commit):
-    command = "git log --pretty='format:%h (\"%s\")' -1 {}".format(commit)
-    dprint(command)
+    """Pretty print the commit message"""
+    command = f"git log --pretty='format:%h (\"%s\")' -1 {commit}"
+    logging.debug(command)
     pipe = os.popen(command)
     return pipe.read()
 
 
+def valid_commit(commit):
+    """Check if the commit is valid or not"""
+    msg = pretty_output(commit)
+    return "Merge tag" not in msg
+
 def check_per_file(file_path):
+    """Check the translation status for the specified file"""
     opath = get_origin_path(file_path)
 
     if not os.path.isfile(opath):
-        dprint("Error: Cannot find the origin path for {}".format(file_path))
+        logging.error("Cannot find the origin path for {file_path}")
         return
 
     o_from_head = get_latest_commit_from(opath, "HEAD")
     t_from_head = get_latest_commit_from(file_path, "HEAD")
 
     if o_from_head is None or t_from_head is None:
-        print("Error: Cannot find the latest commit for {}".format(file_path))
+        logging.error("Cannot find the latest commit for %s", file_path)
         return
 
     o_from_t = get_origin_from_trans(opath, t_from_head)
 
     if o_from_t is None:
-        print("Error: Cannot find the latest origin commit for {}".format(file_path))
+        logging.error("Error: Cannot find the latest origin commit for %s", file_path)
         return
 
     if o_from_head["hash"] == o_from_t["hash"]:
-        if flag_p_uf:
-            print("No update needed for {}".format(file_path))
-        return
+        logging.debug("No update needed for %s", file_path)
     else:
-        print("{}".format(file_path), end="\t")
+        logging.info(file_path)
         commits = get_commits_count_between(
             opath, o_from_t["hash"], o_from_head["hash"]
         )
-        print("({} commits)".format(len(commits)))
-        if flag_p_c:
-            for commit in commits:
-                msg = pretty_output(commit)
-                if "Merge tag" not in msg:
-                    print("commit", msg)
+        count = 0
+        for commit in commits:
+            if valid_commit(commit):
+                logging.info("commit %s", pretty_output(commit))
+                count += 1
+        logging.info("%d commits needs resolving in total\n", count)
+
+
+def valid_locales(locale):
+    """Check if the locale is valid or not"""
+    script_path = os.path.dirname(os.path.abspath(__file__))
+    linux_path = os.path.join(script_path, "..")
+    if not os.path.isdir(f"{linux_path}/Documentation/translations/{locale}"):
+        raise ArgumentTypeError("Invalid locale: {locale}")
+    return locale
+
+
+def list_files_with_excluding_folders(folder, exclude_folders, include_suffix):
+    """List all files with the specified suffix in the folder and its subfolders"""
+    files = []
+    stack = [folder]
+
+    while stack:
+        pwd = stack.pop()
+        # filter out the exclude folders
+        if os.path.basename(pwd) in exclude_folders:
+            continue
+        # list all files and folders
+        for item in os.listdir(pwd):
+            ab_item = os.path.join(pwd, item)
+            if os.path.isdir(ab_item):
+                stack.append(ab_item)
+            else:
+                if ab_item.endswith(include_suffix):
+                    files.append(ab_item)
+
+    return files
+
+
+class DmesgFormatter(logging.Formatter):
+    """Custom dmesg logging formatter"""
+    def format(self, record):
+        timestamp = time.time()
+        formatted_time = f"[{timestamp:>10.6f}]"
+        log_message = f"{formatted_time} {record.getMessage()}"
+        return log_message
+
+
+def config_logging(log_level, log_file="checktransupdate.log"):
+    """configure logging based on the log level"""
+    # set up the root logger
+    logger = logging.getLogger()
+    logger.setLevel(log_level)
+
+    # Create console handler
+    console_handler = logging.StreamHandler()
+    console_handler.setLevel(log_level)
+
+    # Create file handler
+    file_handler = logging.FileHandler(log_file)
+    file_handler.setLevel(log_level)
+
+    # Create formatter and add it to the handlers
+    formatter = DmesgFormatter()
+    console_handler.setFormatter(formatter)
+    file_handler.setFormatter(formatter)
+
+    # Add the handler to the logger
+    logger.addHandler(console_handler)
+    logger.addHandler(file_handler)
 
 
 def main():
+    """Main function of the script"""
     script_path = os.path.dirname(os.path.abspath(__file__))
     linux_path = os.path.join(script_path, "..")
 
@@ -134,62 +202,62 @@ def main():
     parser.add_argument(
         "-l",
         "--locale",
+        default="zh_CN",
+        type=valid_locales,
         help="Locale to check when files are not specified",
     )
+
     parser.add_argument(
-        "--print-commits",
+        "--print-missing-translations",
         action=BooleanOptionalAction,
         default=True,
-        help="Print commits between the origin and the translation",
+        help="Print files that do not have translations",
     )
 
     parser.add_argument(
-        "--print-updated-files",
-        action=BooleanOptionalAction,
-        default=False,
-        help="Print files that do no need to be updated",
-    )
+        '--log',
+        default='INFO',
+        choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'],
+        help='Set the logging level')
 
     parser.add_argument(
-        "--debug",
-        action=BooleanOptionalAction,
-        help="Print debug information",
-        default=False,
-    )
+        '--logfile',
+        default='checktransupdate.log',
+        help='Set the logging file (default: checktransupdate.log)')
 
     parser.add_argument(
         "files", nargs="*", help="Files to check, if not specified, check all files"
     )
     args = parser.parse_args()
 
-    global flag_p_c, flag_p_uf, flag_debug
-    flag_p_c = args.print_commits
-    flag_p_uf = args.print_updated_files
-    flag_debug = args.debug
+    # Configure logging based on the --log argument
+    log_level = getattr(logging, args.log.upper(), logging.INFO)
+    config_logging(log_level)
 
-    # get files related to linux path
+    # Get files related to linux path
     files = args.files
     if len(files) == 0:
-        if args.locale is not None:
-            files = (
-                os.popen(
-                    "find {}/Documentation/translations/{} -type f".format(
-                        linux_path, args.locale
-                    )
-                )
-                .read()
-                .split("\n")
-            )
-        else:
-            files = (
-                os.popen(
-                    "find {}/Documentation/translations -type f".format(linux_path)
-                )
-                .read()
-                .split("\n")
-            )
-
-    files = list(filter(lambda x: x != "", files))
+        offical_files = list_files_with_excluding_folders(
+            os.path.join(linux_path, "Documentation"), ["translations", "output"], "rst"
+        )
+
+        for file in offical_files:
+            # split the path into parts
+            path_parts = file.split(os.sep)
+            # find the index of the "Documentation" directory
+            kindex = path_parts.index("Documentation")
+            # insert the translations and locale after the Documentation directory
+            new_path_parts = path_parts[:kindex + 1] + ["translations", args.locale] \
+                           + path_parts[kindex + 1 :]
+            # join the path parts back together
+            new_file = os.sep.join(new_path_parts)
+            if os.path.isfile(new_file):
+                files.append(new_file)
+            else:
+                if args.print_missing_translations:
+                    logging.info(os.path.relpath(os.path.abspath(file), linux_path))
+                    logging.info("No translation in the locale of %s\n", args.locale)
+
     files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
 
     # cd to linux root directory
-- 
2.43.0


