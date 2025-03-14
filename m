Return-Path: <linux-kernel+bounces-562020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC0A61A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008783BF578
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F681209F54;
	Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNrBPqtu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B53206F1A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980570; cv=none; b=B72RKAzvH1IxEXcUZxSqtWzbQTNtMu7LBWZxo0s80AQLLrbHO/HLChLHAIJDME9gweNdSkOtS/ZA8l5t2x8+OL4vMfuRryFVJdOB9PwBvuh/jifAUCq8fcvlkd7gEHsUHG4Boe/voHRdgh3/CeN/Yp0bvFCRoUC/yPaJ4DmRCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980570; c=relaxed/simple;
	bh=DLEUMff4oGmotsMW0ZULYG9XAEQHCXK90L/aD28LyIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBnGzkzqPm3fGjMwdKK5hVoTNJ2go4LHn2OCUOjndlbMRosqk4efrDphxtTVFvzslOjnfpF7Nzv9CLR69FCjKsviAbdNvBiN+bEWLMJYXijfoss2Fc3Fif8zlkdZ6k0bMXWekUcflZvaNHOXKiXhCJmDSF+NJMehtRMvb14HqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNrBPqtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05429C4CEF0;
	Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980570;
	bh=DLEUMff4oGmotsMW0ZULYG9XAEQHCXK90L/aD28LyIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNrBPqtuEqzwv1IIkRGk4k3b47cAAr6B3c1sug42H/+6YQQx+GXv8efJLP+DbfZYz
	 CVbuNNQQYoBK5zp/Xa0XL+5iD5rzcIOCzs5ay+1wrmzAvPU8/QBaoPC3xoNQYlQcI4
	 VI/m1QsZuoNNK+JKyC2hh4E9NhfZD24A59KyLBndeSD+NCsUYgvQ1F+RbAtto0fUvd
	 sMj0wp+JcOnpYZZLr55qSZ0C+oGmoTPnk1MFyjYxby4lXJYODSN2gNLjG2L3a5oTrM
	 B029xejWIIPc8WdF7J9UhSIGLY24N5SqyC+fYJVnmv3ApCqVmarN8exea5s3cy1USW
	 4BjL9I3Elvevg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 04/13] objtool: Update documentation
Date: Fri, 14 Mar 2025 12:29:02 -0700
Message-ID: <2552ee8b48631127bf269359647a7389edf5f002.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some outdated information in the objtool doc.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt | 95 ++++++++++++++-----------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 87950a7aaa17..28ac57b9e102 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -28,6 +28,15 @@ Objtool has the following features:
   sites, enabling the kernel to patch them inline, to prevent "thunk
   funneling" for both security and performance reasons
 
+- Return thunk validation -- validates return thunks are used for
+  certain CPU mitigations including Retbleed and SRSO
+
+- Return thunk annotation -- annotates all return thunk sites so kernel
+  can patch them inline, depending on enabled mitigations
+
+- Return thunk training valiation -- validate that all entry paths
+  untrain a "safe return" before the first return (or call)
+
 - Non-instrumentation validation -- validates non-instrumentable
   ("noinstr") code rules, preventing instrumentation in low-level C
   entry code
@@ -53,6 +62,9 @@ Objtool has the following features:
 - Function entry annotation -- annotates function entries, enabling
   kernel function tracing
 
+- Function preamble (prefix) annotation and/or symbol generation -- used
+  for FineIBT and call depth tracking
+
 - Other toolchain hacks which will go unmentioned at this time...
 
 Each feature can be enabled individually or in combination using the
@@ -197,19 +209,17 @@ To achieve the validation, objtool enforces the following rules:
 
 1. Each callable function must be annotated as such with the ELF
    function type.  In asm code, this is typically done using the
-   ENTRY/ENDPROC macros.  If objtool finds a return instruction
+   SYM_FUNC_{START,END} macros.  If objtool finds a return instruction
    outside of a function, it flags an error since that usually indicates
    callable code which should be annotated accordingly.
 
    This rule is needed so that objtool can properly identify each
    callable function in order to analyze its stack metadata.
 
-2. Conversely, each section of code which is *not* callable should *not*
-   be annotated as an ELF function.  The ENDPROC macro shouldn't be used
-   in this case.
-
-   This rule is needed so that objtool can ignore non-callable code.
-   Such code doesn't have to follow any of the other rules.
+2. Conversely, each section of code which is *not* callable, or is
+   otherwise doing funny things with the stack or registers, should
+   *not* be annotated as an ELF function.  Rather, SYM_CODE_{START,END}
+   should be used along with unwind hints.
 
 3. Each callable function which calls another function must have the
    correct frame pointer logic, if required by CONFIG_FRAME_POINTER or
@@ -221,7 +231,7 @@ To achieve the validation, objtool enforces the following rules:
    function B, the _caller_ of function A will be skipped on the stack
    trace.
 
-4. Dynamic jumps and jumps to undefined symbols are only allowed if:
+4. Indirect jumps and jumps to undefined symbols are only allowed if:
 
    a) the jump is part of a switch statement; or
 
@@ -304,20 +314,21 @@ the objtool maintainers.
    001e    2823e:  80 ce 02                or     $0x2,%dh
    ...
 
+
 2. file.o: warning: objtool: .text+0x53: unreachable instruction
 
    Objtool couldn't find a code path to reach the instruction.
 
    If the error is for an asm file, and the instruction is inside (or
    reachable from) a callable function, the function should be annotated
-   with the ENTRY/ENDPROC macros (ENDPROC is the important one).
-   Otherwise, the code should probably be annotated with the unwind hint
-   macros in asm/unwind_hints.h so objtool and the unwinder can know the
-   stack state associated with the code.
+   with the SYM_FUNC_START and SYM_FUNC_END macros.
+
+   Otherwise, SYM_CODE_START can be used.  In that case the code needs
+   to be annotated with unwind hint macros.
+
+   If you're sure the code won't affect the reliability of runtime stack
+   traces and want objtool to ignore it, see "Adding exceptions" below.
 
-   If you're 100% sure the code won't affect stack traces, or if you're
-   a just a bad person, you can tell objtool to ignore it.  See the
-   "Adding exceptions" section below.
 
 3. file.o: warning: objtool: foo+0x48c: bar() missing __noreturn in .c/.h or NORETURN() in noreturns.h
 
@@ -326,6 +337,7 @@ the objtool maintainers.
    declaration and its definition, and must have a NORETURN() annotation
    in tools/objtool/noreturns.h.
 
+
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
    file.o: warning: objtool: func()+0x11dd: can't decode instruction
@@ -339,23 +351,21 @@ the objtool maintainers.
 
    This is a kernel entry/exit instruction like sysenter or iret.  Such
    instructions aren't allowed in a callable function, and are most
-   likely part of the kernel entry code.  They should usually not have
-   the callable function annotation (ENDPROC) and should always be
-   annotated with the unwind hint macros in asm/unwind_hints.h.
+   likely part of the kernel entry code.  Such code should probably be
+   placed in a SYM_FUNC_CODE block with unwind hints.
 
 
 6. file.o: warning: objtool: func()+0x26: sibling call from callable instruction with modified stack frame
 
-   This is a dynamic jump or a jump to an undefined symbol.  Objtool
-   assumed it's a sibling call and detected that the frame pointer
-   wasn't first restored to its original state.
+   This is a branch to an UNDEF symbol.  Objtool assumed it's a
+   sibling call and detected that the stack wasn't first restored to its
+   original state.
 
-   If it's not really a sibling call, you may need to move the
-   destination code to the local file.
+   If it's not really a sibling call, you may need to use unwind hints
+   and/or move the destination code to the local file.
 
    If the instruction is not actually in a callable function (e.g.
-   kernel entry code), change ENDPROC to END and annotate manually with
-   the unwind hint macros in asm/unwind_hints.h.
+   kernel entry code), use SYM_CODE_{START,END} and unwind hints.
 
 
 7. file: warning: objtool: func()+0x5c: stack state mismatch
@@ -371,8 +381,8 @@ the objtool maintainers.
 
    Another possibility is that the code has some asm or inline asm which
    does some unusual things to the stack or the frame pointer.  In such
-   cases it's probably appropriate to use the unwind hint macros in
-   asm/unwind_hints.h.
+   cases it's probably appropriate to use SYM_FUNC_CODE with unwind
+   hints.
 
 
 8. file.o: warning: objtool: funcA() falls through to next function funcB()
@@ -382,17 +392,16 @@ the objtool maintainers.
    can fall through into the next function.  There could be different
    reasons for this:
 
-   1) funcA()'s last instruction is a call to a "noreturn" function like
+   a) funcA()'s last instruction is a call to a "noreturn" function like
       panic().  In this case the noreturn function needs to be added to
       objtool's hard-coded global_noreturns array.  Feel free to bug the
       objtool maintainer, or you can submit a patch.
 
-   2) funcA() uses the unreachable() annotation in a section of code
+   b) funcA() uses the unreachable() annotation in a section of code
       that is actually reachable.
 
-   3) If funcA() calls an inline function, the object code for funcA()
-      might be corrupt due to a gcc bug.  For more details, see:
-      https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
+   c) Some undefined behavior like divide by zero.
+
 
 9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
 
@@ -430,24 +439,26 @@ the objtool maintainers.
     This limitation can be overcome by massaging the alternatives with
     NOPs to shift the stack changes around so they no longer conflict.
 
+
 11. file.o: warning: unannotated intra-function call
 
-   This warning means that a direct call is done to a destination which
-   is not at the beginning of a function. If this is a legit call, you
-   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
-   directive right before the call.
+    This warning means that a direct call is done to a destination which
+    is not at the beginning of a function. If this is a legit call, you
+    can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
+    directive right before the call.
+
 
 12. file.o: warning: func(): not an indirect call target
 
-   This means that objtool is running with --ibt and a function expected
-   to be an indirect call target is not. In particular, this happens for
-   init_module() or cleanup_module() if a module relies on these special
-   names and does not use module_init() / module_exit() macros to create
-   them.
+    This means that objtool is running with --ibt and a function
+    expected to be an indirect call target is not. In particular, this
+    happens for init_module() or cleanup_module() if a module relies on
+    these special names and does not use module_init() / module_exit()
+    macros to create them.
 
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
-Feel free to ask the objtool maintainer for help.
+Feel free to ask objtool maintainers for help.
 
 
 Adding exceptions
-- 
2.48.1


