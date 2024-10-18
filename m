Return-Path: <linux-kernel+bounces-372176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4959A454F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A67C1F22082
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C12038BE;
	Fri, 18 Oct 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="cdRCJqEj"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A38370;
	Fri, 18 Oct 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274143; cv=none; b=u4TS/Vt5NMrjYEMA8cpoWzA9JFkz2MObjHOfabb1bQJDzJHu9KcMIAGP5ziGiCvr0DVm0POkXQXF64GR83zrIBzh7TCUA5MRXcGLeRkf+xubwKFGSBl+ggZ3IToJLOCIyTtEzrrbRWUwpxS6x5HXqXxN3Gc1Kub2Sf1dwBaVAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274143; c=relaxed/simple;
	bh=TkvnOKXF7XGGKCA+xeQ2PbjFHpKzLCM3l+ml11uMLX4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8BDG8HBmnPddQceDZWyj4H/rg0h73hNDZrWaRZXi09umTNZuXzU1GCUEekFnMydGp6XLL/lp6DhPoQ7e+GcQqbWBGzEqQ6mEeuksr3sbLpyZvId7F+m2kmGoZBBPiwZj85TzlI+Zgz+vwDG1lVaXgV2kFF2FSols/n1nRMTclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=cdRCJqEj; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 5F5EC177103; Fri, 18 Oct 2024 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729274140; bh=TkvnOKXF7XGGKCA+xeQ2PbjFHpKzLCM3l+ml11uMLX4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cdRCJqEjNGsBRa2yrH6cshOfztjbm9ycCDvfbVzWJ5S61hjxvPHHF3wWj+EyQhs7f
	 5OnkkSlP0ieFi6iaDP3JKwW5rJ+pLu3ol4vkoaWEHC+o7g80b3iEXd/+kODI/aFjAj
	 jW1wblSk6KZIWz2dXZQykMB98fHyZv+i36UJLagamA38urhtH98hCUX1qDTSJBInpC
	 EOXCLvMPE8uR6x6QkDI8V13IrJFSPRaRXSBwl95rUWm2wK386W+1/ASBS7Pkpdprfe
	 hviyfx2gVS+xqcgQlmtPYHgbk3xwJB+8NzzYrhp4uhrJM9DAsnEZK9/ct/+SBy5spH
	 DKi0cRCBh8x3w==
Date: Fri, 18 Oct 2024 17:55:40 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: English fixes in kgdb/kdb article
Message-ID: <20241018175540.GA796909@lichtman.org>
References: <20241018163136.GA795979@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018163136.GA795979@lichtman.org>

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
+At run time you can enable or disable kgdboc by writing parameters
 into sysfs. Here are two examples:
 
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

