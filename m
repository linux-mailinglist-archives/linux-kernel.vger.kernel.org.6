Return-Path: <linux-kernel+bounces-528514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2118A4187E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D495189781E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCE257AE9;
	Mon, 24 Feb 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZXKezhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797124A072;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=s5TfLsfzB6jGGaB16RH5E8XqpJSuH/Kbrm77hDswXgK3Iy+TZdv1jbQvMQfIUCu2R7yr44EbfKld84GL3cfgWNwvnsOTr0KOXN9wyXLNDEcGeotq1GiZXAEI54XzC5Sui6x+LWHv4lNi5cccMp3nO9/EAg3nHUHEL+soja+Se5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=6Zn2EKfxJ7Vkt0h37tV3CPuGsXDQh4z4UJHEkZnGtBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXYAm26vp9fdFiW2pt/OJJPK8co34sq1J2k4zZlO9YEbnGRq+gVkE1WdptJnCQbilBExk/lQL7CHcfmOZq0niA1mXNGFfGLNg0Sqmo9ss/C3HpJiv8R0EDjj1jzx8ujSMq7j8tywglv5s9L4+8mmRyrLARM5mGf6SVnYm8b/wPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZXKezhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D213C4CEE6;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=6Zn2EKfxJ7Vkt0h37tV3CPuGsXDQh4z4UJHEkZnGtBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZXKezhRCWrPHNJ6trrfgHP5zygH1/n/1mrk7C9h6dRpwIQYALoe9HPRl3kFolPi6
	 ILEYi/S3G4F7pkxUFFt5NQ1enQ1lSgc3LUb4I6DAZoxOIxAB8yTTxOBtg3MDlSwF5p
	 E90YkCVlwELulaBELLNNLTMiS6mZfmQ5pWBm1kmF9LaMZ79Z3apQrs/akaPlgzAyC2
	 nsljM2WMvgk7F9wazacDFx6lWN0Kx6VGXVgvOIaEgreRgb20DL6Ydovr1D0AHjO4fZ
	 Gq3fec9mSHEHBBbI627I4uzyNuGk2gjFBOUtVazoJqMcAFpefsFu5TwoTZWCn9zX6/
	 TKTEvqW+ysbuQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5J-2PsT;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/39] scripts/kernel-doc.py: adjust some coding style issues
Date: Mon, 24 Feb 2025 10:08:35 +0100
Message-ID: <b7e9f38e1689bb38bca659d7b87b89e445b9f6ff.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Make pylint happier by adding some missing documentation and
addressing a couple of pylint warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           |  2 ++
 scripts/lib/kdoc/kdoc_files.py  |  4 +--
 scripts/lib/kdoc/kdoc_output.py | 51 ++++++++++++++++++++++++++-------
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index d700451e9541..daae2b4f3307 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -90,6 +90,8 @@ neither here nor at the original Perl script.
 
 
 class MsgFormatter(logging.Formatter):
+    """Helper class to format warnings on a similar way to kernel-doc.pl"""
+
     def format(self, record):
         record.levelname = record.levelname.capitalize()
         return logging.Formatter.format(self, record)
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 957aaeaed7e6..e1ed2f6dae94 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -3,8 +3,6 @@
 # Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
 # SPDX-License-Identifier: GPL-2.0
 
-# TODO: implement warning filtering
-
 """
 Parse lernel-doc tags on multiple kernel source files.
 """
@@ -127,7 +125,7 @@ class KernelFiles():
     def __init__(self, verbose=False, out_style=None,
                  werror=False, wreturn=False, wshort_desc=False,
                  wcontents_before_sections=False,
-                 logger=None, modulename=None, export_file=None):
+                 logger=None, modulename=None):
         """
         Initialize startup variables and parse all files
         """
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 7aeaec884545..97ec671e0b6e 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -1,10 +1,8 @@
 #!/usr/bin/env python3
-# pylint: disable=C0301,R0911,R0912,R0913,R0914,R0915,R0917
+# pylint: disable=C0301,R0902,R0911,R0912,R0913,R0914,R0915,R0917
 # Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
 # SPDX-License-Identifier: GPL-2.0
 
-# TODO: implement warning filtering
-
 """
 Implement output filters to print kernel-doc documentation.
 
@@ -51,6 +49,11 @@ type_member_func = type_member + Re(r"\(\)", cache=False)
 
 
 class OutputFormat:
+    """
+    Base class for OutputFormat. If used as-is, it means that only
+    warnings will be displayed.
+    """
+
     # output mode.
     OUTPUT_ALL          = 0 # output all symbols and doc sections
     OUTPUT_INCLUDE      = 1 # output only specified symbols
@@ -74,6 +77,10 @@ class OutputFormat:
         self.data = ""
 
     def set_config(self, config):
+        """
+        Setup global config variables used by both parser and output.
+        """
+
         self.config = config
 
     def set_filter(self, export, internal, symbol, nosymbol, function_table,
@@ -116,6 +123,10 @@ class OutputFormat:
         return block
 
     def out_warnings(self, args):
+        """
+        Output warnings for identifiers that will be displayed.
+        """
+
         warnings = args.get('warnings', [])
 
         for warning, log_msg in warnings:
@@ -145,6 +156,11 @@ class OutputFormat:
         return False
 
     def check_declaration(self, dtype, name, args):
+        """
+        Checks if a declaration should be output or not based on the
+        filtering criteria.
+        """
+
         if name in self.nosymbol:
             return False
 
@@ -168,6 +184,10 @@ class OutputFormat:
         return False
 
     def msg(self, fname, name, args):
+        """
+        Handles a single entry from kernel-doc parser
+        """
+
         self.data = ""
 
         dtype = args.get('type', "")
@@ -202,24 +222,24 @@ class OutputFormat:
         return None
 
     # Virtual methods to be overridden by inherited classes
+    # At the base class, those do nothing.
     def out_doc(self, fname, name, args):
-        pass
+        """Outputs a DOC block"""
 
     def out_function(self, fname, name, args):
-        pass
+        """Outputs a function"""
 
     def out_enum(self, fname, name, args):
-        pass
+        """Outputs an enum"""
 
     def out_typedef(self, fname, name, args):
-        pass
+        """Outputs a typedef"""
 
     def out_struct(self, fname, name, args):
-        pass
-
+        """Outputs a struct"""
 
 class RestFormat(OutputFormat):
-    # """Consts and functions used by ReST output"""
+    """Consts and functions used by ReST output"""
 
     highlights = [
         (type_constant, r"``\1``"),
@@ -264,6 +284,11 @@ class RestFormat(OutputFormat):
             self.data += f".. LINENO {ln}\n"
 
     def output_highlight(self, args):
+        """
+        Outputs a C symbol that may require being converted to ReST using
+        the self.highlights variable
+        """
+
         input_text = args
         output = ""
         in_literal = False
@@ -578,6 +603,10 @@ class ManFormat(OutputFormat):
         self.man_date = dt.strftime("%B %Y")
 
     def output_highlight(self, block):
+        """
+        Outputs a C symbol that may require being highlighted with
+        self.highlights variable using troff syntax
+        """
 
         contents = self.highlight_block(block)
 
@@ -600,7 +629,7 @@ class ManFormat(OutputFormat):
         sections = args.get('sections', {})
 
         if not self.check_doc(name, args):
-                return
+            return
 
         self.data += f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
-- 
2.48.1


