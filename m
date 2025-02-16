Return-Path: <linux-kernel+bounces-516579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF348A37443
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323E71888968
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525F191499;
	Sun, 16 Feb 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0z2k2Fj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A51519B4;
	Sun, 16 Feb 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710441; cv=none; b=hzKIvUYjONbe3aD4DLdXMtaRKkhaX6VgeZxDf80tM8N7OAMxfHHHFpbso+pmbV7dFv/ODu/5oGmX5yWZdbEbrCu+yi3Lgg0CArlI8A391VgbUS4bA8LOd5u+KpvqfB5ALdNaP3kXWJ0WAYuwTPE19WSuxbOuyXrqKNcJTe0RlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710441; c=relaxed/simple;
	bh=29ig6alKZBu4X69G3jeBcuUStHksKRdqHVV1bBGzCBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvPJV530sIDivjFp8AKQAvyrkFhBUvm1gM+Qch/vnW6WmA0xxV3Cf0x5USP6v94UGmk5Gpi40mXX6UsGkq/eVG+YdNCX5UBQ8nayJ5FQ1F0VM2Llygi4uorRsNgMMxzREiYY4GfCgsB3TkAuBZScQWk1wxvOWBaNU7u0uzUq2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0z2k2Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77966C4CEDD;
	Sun, 16 Feb 2025 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739710440;
	bh=29ig6alKZBu4X69G3jeBcuUStHksKRdqHVV1bBGzCBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0z2k2FjopULZbXmQ9g+wmdrDfxmJwLt88yeBU0CVkIancv8FSrFyy3E0mI0TpKeG
	 rRRSRlCYAu9+sB8ewRD1p2Rzg/3LI6FIkbs9kTR17UV6891Yr4giaKAPC0K8U5s2pQ
	 k95nm3NOGpSRIqNJ/qclQ0w5pSlOm27x/R0wGNr8XJv6ceP8f7VD2U3j2l3FcAWNaT
	 uZlVfmMizMbgbhg7fpG8wibaC8Sdt33asj0dflSsYKxmSJrYxeX4qMyFhBcB95TT64
	 r7WRJUEhsbxydboIjMqOrVgSfPS608cbZuS5a3q6cCc9zv2XJIFH7AayQn88kzpIBT
	 qCVteGNvjJjtQ==
Date: Sun, 16 Feb 2025 13:53:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 18/38] docs: sphinx/kernel_abi: use AbiParser directly
Message-ID: <20250216135356.188be652@foz.lan>
In-Reply-To: <20250210170354.18c04f7c@sal.lan>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
	<fb800900352d90a0e501e5d6732e1bea277478f2.1738020236.git.mchehab+huawei@kernel.org>
	<87lduu7efu.fsf@trenco.lwn.net>
	<20250129014324.60a8dfce@foz.lan>
	<20250202155652.1652e420@foz.lan>
	<878qqlfxc9.fsf@trenco.lwn.net>
	<20250210082748.05ba85ae@foz.lan>
	<87cyfp3ltp.fsf@trenco.lwn.net>
	<20250210170354.18c04f7c@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 10 Feb 2025 17:03:54 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Mon, 10 Feb 2025 07:40:02 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >   
> > > I took a look on Markus work: it was licensed under GPL 3.0 and it was
> > > written in 2016. There were several changes on kerneldoc since them,
> > > including the addition of a regex that it is not compatible with
> > > Python re[1]:
> > >
> > >         $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
> > >
> > > This one use:
> > >
> > > 	- recursive patterns: ?1
> > > 	- atomic grouping (?>...)
> > >
> > > Also, it is hard to map what he does with the existing script. I'm
> > > opting to write a new script from scratch.    
> > 
> > That's fine, I just wanted to be sure you'd had a chance to look at
> > it... 
> >   
> > >     Another option would be to re-implement such regexes without using
> > >     such advanced patterns.    
> > 
> > Seems like a preferred option if that can be done.  Banging one's head
> > against all those regexes is often the hardest part of dealing with that
> > script; anything that makes it simpler is welcome.  
> 
> Agreed. This one, in special, is very hard for me to understand, as I
> never used recursive patterns or atomic grouping. The net result of
> the struct_group*() handling is that it removes some parameters when
> generating the function prototype. This is done using a complex logic
> on two steps:
> 
>        # unwrap struct_group():
>         # - first eat non-declaration parameters and rewrite for final match
>         # - then remove macro, outer parens, and trailing semicolon
>         $members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
>         $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>         $members =~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2; STRUCT_GROUP(/gos;
>         $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
>         $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
> 
> 
> The first step basically eliminates some members of the function. At the
> places I checked, the second step was just removing parenthesis from the
> macro (and the STRUCT_GROUP name).
> 
> I suspect that the same result could be done with a much simpler expression
> like:
> 
> 	$members =~ s/\bSTRUCT_GROUP\((.*)\)[^;]*;/$2/gos;
> 
> But maybe there are some corner cases that would cause such simpler
> regex to fail.

A simpler regex didn't work.

Instead of using Python regex module and keep such complex regular
expressions, I opted to implement it on a completely different way.
See patch below.

Basically, I implemented a new class (NestedMatch) just to
handle patterns like:

	FOO(.*)

converting them into:

	.*

I expect that the new logic there would work properly for any
number of [], {} and () paired delimiters.

I ended writing such class from scratch, based on a suggestion from
stackoverflow.

Using such logic, replacing STRUCT_GROUP(.*) by .* is as simple
as:

        sub_nested_prefixes = [
            (re.compile(r'\bSTRUCT_GROUP'),  r'\1'),
        ]

        nested = NestedMatch()

        for search, sub in sub_nested_prefixes:
            members = nested.sub(search, sub, members)

This should probably help cleaning up other similar patterns.
Let's see. Anyway, I expect that this would make the C parsing
part easier to maintain.

For the first version, I'll use the new way only when I notice
discrepancies between Perl and Python versions.

Thanks,
Mauro

---

[PATCH] scripts/kernel-doc.py: properly handle struct_group macros

Handing nested parenthesis with regular expressions is not an
easy task. It is even harder with Python's re module, as it
has a limited subset of regular expressions, missing more
advanced features.

We might use instead Python regex module, but still the
regular expressions are very hard to understand. So, instead,
add a logic to properly match delimiters.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 9b10fd05b6af..df824692c4e7 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -92,6 +92,138 @@ class Re:
     def group(self, num):
         return self.last_match.group(num)
 
+class NestedMatch:
+    """
+    Finding nested delimiters is hard with regular expressions. It is
+    even harder on Python with its normal re module, as there are several
+    advanced regular expressions that are missing.
+
+    This is the case of this pattern:
+
+            '\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;'
+
+    which is used to properly match open/close parenthesis of the
+    string search STRUCT_GROUP(),
+
+    Add a class that counts pairs of delimiters, using it to match and
+    replace nested expressions.
+
+    The original approach was suggested by:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+
+    Although I re-implemented it to make it more generic and match 3 types
+    of delimiters. The logic checks if delimiters are paired. If not, it
+    will ignore the search string.
+    """
+
+    DELIMITER_PAIRS = {
+        '{': '}',
+        '(': ')',
+        '[': ']',
+    }
+
+    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
+
+    def _search(self, regex, line):
+        """
+        Finds paired blocks.
+
+        If a given regex is not empty, the logic will first seek for its
+        position, and then handles the next delimiters afterwards
+
+        The suggestion of using finditer to match pairs came from:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+        but I ended using a different implementation to align all three types
+        of delimiters and seek for an initial regular expression.
+
+        The algorithm seeks for open/close paired delimiters and place them
+        into a stack, yielding a start/stop position of each match  when the
+        stack is zeroed.
+
+        The algorithm shoud work fine for properly paired lines, but will
+        silently ignore end delimiters that preceeds an start delimiter.
+        This should be OK for kernel-doc parser, as unaligned delimiters
+        would cause compilation errors. So, we don't need to rise exceptions
+        to cover such issues.
+        """
+
+        stack = []
+
+        for match_re in regex.finditer(line):
+            offset = match_re.end()
+
+            for match in self.RE_DELIM.finditer(line[offset:]):
+                pos = match.start() + offset
+
+                d = line[pos]
+
+                if d in self.DELIMITER_PAIRS.keys():
+                    end = self.DELIMITER_PAIRS[d]
+
+                    stack.append(end)
+                    continue
+
+                # Does the end delimiter match what it is expected?
+                if stack and d == stack[-1]:
+                    stack.pop()
+
+                    if not stack:
+                        yield offset, pos + 1
+
+    def search(self, regex, line):
+        """
+        This is similar to re.search:
+
+        It matches a regex that it is followed by a delimiter,
+        returning occurrences only if all delimiters are paired.
+        """
+
+        for prev_pos, pos in self._search(regex, line):
+
+            yield line[prev_pos:pos]
+
+    def sub(self, regex, sub, line, count=0):
+        """
+        This is similar to re.sub:
+
+        It matches a regex that it is followed by a delimiter,
+        replacing occurrences only if all delimiters are paired.
+
+        if r'\1' is used, it works just like re: it places there the
+        matched paired data with the delimiter stripped.
+
+        If count is different than zero, it will replace at most count
+        items.
+        """
+        out = ""
+
+        cur_pos = 0
+        n = 0
+
+        for start, end in self._search(regex, line):
+            out += line[cur_pos:start]
+
+            # Value, ignoring start/end delimiters
+            value = line[start + 1:end - 1]
+
+            # replaces \1 at the sub string, if \1 is used there
+            new_sub = sub
+            new_sub = new_sub.replace(r'\1', value)
+
+            out += new_sub
+
+            cur_pos = end
+            n += 1
+
+            if count and count >= n:
+                break
+
+        # Append the remaining string
+        l = len(line)
+        out += line[cur_pos:l]
+
+        return out
+
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
 #
@@ -667,19 +799,40 @@ class KernelDoc:
             # Unwrap struct_group() based on this definition:
             # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
             # which has variants like: struct_group(NAME, MEMBERS...)
+            #
+            # Parsing them are done on two steps:
+            # 1. drop arguments that aren't struct names;
+            # 2. remove STRUCT_GROUP() ancillary macro.
+            #
+            # NOTE: the original logic which replaces STRUCT_GROUP(.*) by .*
+            # is incompatible with Python re, as it uses:
+            #
+            #   - a recursive pattern: (?1)
+            #   - an atomic grouping: (?>...)
+            #
+            # This is the original expression:
+            #   '\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;'
+            #
+            # I tried a simpler version: but it didn't work either:
+            #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
+            #
+            # As it doesn't properly match the end parenthesis.
+            #
+            # So, a better solution was crafted: there's now a NestedMatch
+            # class that ensures that delimiters after a search are properly
+            # matched. So, the implementation to drop STRUCT_GROUP() will be
+            # handled in separate.
 
             (Re(r'\bstruct_group\s*\(([^,]*,)', re.S),  r'STRUCT_GROUP('),
             (Re(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S),  r'STRUCT_GROUP('),
             (Re(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S),  r'struct \1 \2; STRUCT_GROUP('),
             (Re(r'\b__struct_group\s*\(([^,]*,){3}', re.S),  r'STRUCT_GROUP('),
 
-            # This is incompatible with Python re, as it uses:
-            #  recursive patterns ((?1)) and atomic grouping ((?>...)):
-            #   '\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;'
-            # Let's see if this works instead:
-            (Re(r'\bSTRUCT_GROUP\(([^\)]+)\)[^;]*;', re.S),  r'\1'),
-
             # Replace macros
+            #
+            # TODO: it is better to also move those to the NestedMatch logic,
+            # to endure that parenthesis will be properly matched.
+
             (Re(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),  r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
             (Re(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),  r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
             (Re(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'unsigned long \1[BITS_TO_LONGS(\2)]'),
@@ -691,9 +844,18 @@ class KernelDoc:
             (Re(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S),  r'__u32 \1'),
         ]
 
+        sub_nested_prefixes = [
+            (re.compile(r'\bSTRUCT_GROUP'),  r'\1'),
+        ]
+
         for search, sub in sub_prefixes:
             members = search.sub(sub, members)
 
+        nested = NestedMatch()
+
+        for search, sub in sub_nested_prefixes:
+            members = nested.sub(search, sub, members)
+
         # Keeps the original declaration as-is
         declaration = members
 





