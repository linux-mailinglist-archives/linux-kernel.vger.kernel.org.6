Return-Path: <linux-kernel+bounces-372515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7991A9A49B4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BD1C228D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA119047A;
	Fri, 18 Oct 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="cJJb/WMM"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2A188CDC;
	Fri, 18 Oct 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290939; cv=none; b=jwfXNyVUDPlYzlDvkgqQrpjEaVSgxzHG56GAW6tPryGO5vqzcnAFiX8ccmYhzTc0OoMzNukgXgaeDpsBEtfAZaIC6rVfEN2YDhBKlUsyp8BM4idxL9qiJoVXGIRiOKiew29kLlHtWdMG8KTwaHVFB8eJuyzM9sxkmor3XTC/k2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290939; c=relaxed/simple;
	bh=XD+AGUUFq4jivFWzDw1zmD0eWk5I2XvZ7EZuQDspZLw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4KnsTCF0ZmMsmpxJ9HpeUGguYjbc1mx2hU5XUTsOvkXAylsdmuUawLaURYnBms7eZJjoluH2rn1VIX+QBevJH11ovQIjscPdB4bXBMPoFzMGGOMWHm2p7+GcDcRnklOvVuWix3Wd2XKZEHQF8H4zWsT18y9cXOkvPnXlA/TCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=cJJb/WMM; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 92D25177103; Fri, 18 Oct 2024 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729290936; bh=XD+AGUUFq4jivFWzDw1zmD0eWk5I2XvZ7EZuQDspZLw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cJJb/WMM2I9a4GNvjDM0CcQ7HqfWVrf9LfS4jZITB9SngAsyknaz6qN4Y5ecEinuk
	 I2DQpVR7kJMmKNbiaHsnBWshOgMXw5euvmzwxm6G4vvnUpyvBpgY93/2zxSJayhclP
	 29Ll6jWbd1gqWJ78nInMPoXmLQy0vihPor+wMdkUkVUB3iarmpu5UB866ed9/W7PuV
	 gdDBq6qcW9rR2znYZGRO1i9jXWoAIds+UUGbA7yaWTfxTpilDX30cDywiqSAmSrQrt
	 0seBGXMrqBKmYonfHISJHJyg8PCrjaFiHK2hnmT0Ho32cTxgMRskjNOjjIs+u6e8NQ
	 SDKE8byw5X46A==
Date: Fri, 18 Oct 2024 22:35:36 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Documentation: English fixes in kgdb/kdb article
Message-ID: <20241018223536.GA799515@lichtman.org>
References: <20241018163136.GA795979@lichtman.org>
 <20241018175540.GA796909@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018175540.GA796909@lichtman.org>

Minor grammar and typos fixed in the kgdb/kdb article

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 Documentation/dev-tools/kgdb.rst | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index f83ba2601e55..9e0e3f3235ef 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -75,11 +75,11 @@ supports it for the architecture you are using, you can use hardware
 breakpoints if you desire to run with the ``CONFIG_STRICT_KERNEL_RWX``
 option turned on, else you need to turn off this option.
 
-Next you should choose one of more I/O drivers to interconnect debugging
+Next you should choose one or more I/O drivers to interconnect the debugging
 host and debugged target. Early boot debugging requires a KGDB I/O
 driver that supports early debugging and the driver must be built into
 the kernel directly. Kgdb I/O driver configuration takes place via
-kernel or module parameters which you can learn more about in the in the
+kernel or module parameters which you can learn more about in the
 section that describes the parameter kgdboc.
 
 Here is an example set of ``.config`` symbols to enable or disable for kgdb::
@@ -201,7 +201,7 @@ Using loadable module or built-in
 Configure kgdboc at runtime with sysfs
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-At run time you can enable or disable kgdboc by echoing a parameters
-into the sysfs. Here are two examples:
+At run time you can enable or disable kgdboc by writing parameters
+into sysfs. Here are two examples:
 
 1. Enable kgdboc on ttyS0::
@@ -374,10 +374,10 @@ default behavior is always set to 0.
 Kernel parameter: ``nokaslr``
 -----------------------------
 
-If the architecture that you are using enable KASLR by default,
+If the architecture that you are using enables KASLR by default,
 you should consider turning it off.  KASLR randomizes the
-virtual address where the kernel image is mapped and confuse
-gdb which resolve kernel symbol address from symbol table
+virtual address where the kernel image is mapped and confuses
+gdb which resolves addresses of kernel symbols from the symbol table
 of vmlinux.
 
 Using kdb
@@ -631,8 +631,6 @@ automatically changes into kgdb mode.
 
 	kgdb
 
-   Now disconnect your terminal program and connect gdb in its place
-
 2. At the kdb prompt, disconnect the terminal program and connect gdb in
    its place.
 
@@ -749,7 +747,7 @@ The kernel debugger is organized into a number of components:
    helper functions in some of the other kernel components to make it
    possible for kdb to examine and report information about the kernel
    without taking locks that could cause a kernel deadlock. The kdb core
-   contains implements the following functionality.
+   implements the following functionality.
 
    -  A simple shell
 
-- 
2.39.2

