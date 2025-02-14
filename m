Return-Path: <linux-kernel+bounces-514263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE7A354CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35A43AC227
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D881013C67E;
	Fri, 14 Feb 2025 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCoI+NMY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2570825;
	Fri, 14 Feb 2025 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500741; cv=none; b=BU8te1D/HRpyYBb+mSyzPW529Q2ARGpi6ZaagfyMFDnIie6XmYjOPy06FcmrAzLrIid5Nm3LuIN6eM0ilgKxjqxG8DXt+0GgfDlWTGoseem6GMFvHCH3T2NQp4dGKYHfp3lKGnKvvrObw2a0DzQZv2pFzKDvLqgKxG+VNUjD4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500741; c=relaxed/simple;
	bh=smdnHJYzlxPxd9k25lNumQWUhSlWl+DD6RhFUe6nx5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acgnvc5kAcxzqdnm/lRj8mmtk7zIc1woKsxgp3R/cUlgbw00vAFie7wDZNAc+6BQitMVKlfZ0Eug3od/V1yxchWK6o0L2gtis/n2VIu4haC72wOgdQ3eVp7yEW3FKAc653Sgqfp4mH6+snUNSllLa8pZ+Bg/4OJpThS7A9GEyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCoI+NMY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=25bbqQa7YMXs0lkfEqR1DKGHHbfacs+OqWdnJ67C+TY=; b=CCoI+NMYeuibMMDXcygIuxfdrf
	7NsLDMv7axvAllWL2ACd0+RMpqF0oJ6k8fIQsMQ4lmmtR5h0Agy+jqep3I4BhKoB/Rabh/PvPS4O3
	tuOdamrtuSSG4x57xPSLHRAm+Q9Odq4QHjlk4luQgr7ikX86jjLI29vSLt3aJo6fl91+VtPGC4Drm
	7r+oe6nE2Cso8XzyITDzji6cIpmbMJ5sF6su7iklaBK4aSxwalgxGQUNOpGRtr1Yp3bcv+C+ramZF
	l1eu76uyVi+ZHHeZH40/7bK6r9KvbKG3QHGgv42cp3OGm37KbmDao77uFnumeRA3e0/NCcU6QtYEe
	kPxiaKFw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tilbO-00000009wn8-0hrA;
	Fri, 14 Feb 2025 02:38:50 +0000
Message-ID: <45cec6dc-2071-4d5a-a0bd-8ad895b19000@infradead.org>
Date: Thu, 13 Feb 2025 18:38:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: remove an obscure logic from
 kernel-doc
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
References: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
 <87wmdt6bv5.fsf@trenco.lwn.net> <20250214032457.6444ee93@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250214032457.6444ee93@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/13/25 6:24 PM, Mauro Carvalho Chehab wrote:
> Em Thu, 13 Feb 2025 09:35:58 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>>
>>> Kernel-doc has an obscure logic that uses an external file
>>> to map files via a .tmp_filelist.txt file stored at the current
>>> directory. The rationale for such code predates git time,
>>> as it was added on Kernel v2.4.5.5, with the following description:
>>>
>>> 	# 26/05/2001 -         Support for separate source and object trees.
>>> 	#              Return error code.
>>> 	#              Keith Owens <kaos@ocs.com.au>
>>>
>>> from commit 396a6123577d ("v2.4.5.4 -> v2.4.5.5") at the historic
>>> tree:
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
>>>
>>> Support for separate source and object trees is now done on a different
>>> way via make O=<object>.
>>>
>>> There's no logic to create such file, so it sounds to me that this is
>>> just dead code.
>>>
>>> So, drop it.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> ---
>>>  scripts/kernel-doc | 19 +------------------
>>>  1 file changed, 1 insertion(+), 18 deletions(-)  
>>
>> Weird ... I went and looked, and can't find anything that ever created
>> that tmp_filelist.txt file; I wonder if this code ever did anything?
> 
> I wonder the same ;-) Anyway, better to remove this now, as, if people
> complain, it would be easier to revert than after switching to the
> Python version.
> 
>> Don't put that functionality into the Python version :)
> 
> Yeah, I started implementing it, but it sounded a waste of time, so
> I dropped it from the RFC versions. It sounded too complex for people
> to maintain a separate tmp file when make O=dir would do it on a much
> better and automated way.
> 
> -
> 
> With regards to the Python transition, since our Makefile allows
> switching to a different script since ever[1], I'm playing with 
> the idea of sending a patch series with:
> 
> Patch 1: 
>   - drops Sphinx version check from both kerneldoc 
>     (-sphinx-version parameter) and the corresponding Sphinx extension;
> 

It's currently scripts/kernel-doc. Are you planning to change it to
scripts/kerneldoc and break other scripts and makefiles?

> patch 2: 
>   - renames kerneldoc to kerneldoc.pl
>   - creates a symlink:
> 	kerneldoc.pl -> kerneldoc
> 
> patch 3:
>   - adds kerneldoc.py:
> 
> patch 4:
>   - add info messages on both versions related to the transition,
>     and instructions about using KERNELDOC=<script> makefile and ask
>     people to report eventual regressions with new script.
> 
> patch 5:
>   - change kerneldoc symlink to point to kerneldoc.py
> 
> We can then keep both for maybe one Kernel cycle and see how it goes,
> stop accepting patches to the Perl version, in favor of doing the needed
> changes at the Python one.
> 
> If everything goes well, we can remove the venerable Perl version on the 
> upcoming merge window, and change the Sphinx extension to use the Python
> classes directly instead of running an external executable code.
> 
> What do you think?
> 
> -
> 
> I'm in doubt if I should split the Kernel classes for the Python version
> into a scripts/lib/kdoc directory on this series or doing such change
> only after we drop the Perl version.
> 
> Keeping it on a single file helps to do more complex code adjustments 
> on a single place, specially if we end renaming/shifting stuff[2].
> 
> [1] I didn't remember about that - it is a very welcomed feature,
>     probably thanks to Markus.
> 
> [2] the currently global const regex macros is something that I want
>     to rename and place them inside a class (or on multiple classes).
>     Also, Python coding style is to use uppercase for const. There is
>     currently a Pylint disabled warning about that. So, I do plan to
>     do such changes in the future to make it more compatible with
>     Python coding style.
> 
> -
> 
> On a separate but related issue, perhaps we should start talking about
> coding style. We don't have anything defined at the Kernel, and
> different scripts follow different conventions (or most likely
> don't follow any convention at all). We should probably think having 
> something defined in the future.
> 
> From my side, I like Pylint warnings, except for the (IMHO) useless "Rxxx"
> warnings that complains about too many/too few things. They have
> been useful to detect hidden bugs at scripts, and it allows inlined
> exceptions to the coding style.
> 
> autopep8 autoformatter is also nice (and, up to some point, black),
> as it auto-corrects whitespace issues, but there's two things I don't 
> like on them:
> 
> 1. its coding style on lines, creating function calls with open 
>    parenthesis:
> 
> 	-    parser.add_argument("-n", "-nosymbol", "--nosymbol", action='append',
> 	-                         help=NOSYMBOL_DESC)
> 	+    parser.add_argument(
> 	+        "-n", "-nosymbol", "--nosymbol", action="append", help=NOSYMBOL_DESC
> 	+    )
> 
> 2. whitespace removal on aligned consts:
> 
> 	-    STATE_INLINE_NA     = 0 # not applicable ($state != STATE_INLINE)
> 	-    STATE_INLINE_NAME   = 1 # looking for member name (@foo:)
> 	-    STATE_INLINE_TEXT   = 2 # looking for member documentation
> 	-    STATE_INLINE_END    = 3 # done
> 	-    STATE_INLINE_ERROR  = 4 # error - Comment without header was found.
> 	-                            # Spit a warning as it's not
> 	-                            # proper kernel-doc and ignore the rest.
> 	+    STATE_INLINE_NA = 0  # not applicable ($state != STATE_INLINE)
> 	+    STATE_INLINE_NAME = 1  # looking for member name (@foo:)
> 	+    STATE_INLINE_TEXT = 2  # looking for member documentation	
> 	+    STATE_INLINE_END = 3  # done
> 	+    STATE_INLINE_ERROR = 4  # error - Comment without header was found.
> 
> What I do here is from time to time manually run them and cherry-pick
> only changes that sounds good to my personal taste.
> 
> It is probably a good idea to define a coding style and perhaps add
> some config files (like a .pep8 file) to have a single coding style for
> future code, letting scripts/checkpatch.pl to run pylint and/or some
> other coding style tool(s).
> 
> Thanks,
> Mauro
> 

-- 
~Randy


