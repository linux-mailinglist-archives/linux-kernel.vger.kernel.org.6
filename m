Return-Path: <linux-kernel+bounces-372062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F399A43EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD811F2442B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174FA2036F2;
	Fri, 18 Oct 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="CTLQDGbX"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4197165EFC;
	Fri, 18 Oct 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269447; cv=none; b=LDGezMSZ4qvf68IQIbtS6/jqmWoqA8z0jLoP9fjNVfOeaohJgbrzot+W4IENOZoN5scOCH6/5dizNk6hXTbJSYbs0psm1jEk2KfMEFGf8AMALUxlJtKJnOO2zxyYtNlhOOpyRMO6BIa75URDbaEb7wQO/G2vmW8Xo6WX5/ByJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269447; c=relaxed/simple;
	bh=iznIP1CQ2RKWwk7uUDU5rLTH1EXRc5AplndOTJbAEBA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XyVENV110SmL3cjK9z5aMVPby1l6cH/Yl2x70Gq8JlUmvNCa2SKc3rhsQCA2NCZtEk2A38ojiBufMm8CaVkua6lmWR0s980gkQmjM2cJA/Ak7JYE79QTZ2GFR15euj70G523M/aEhvTbmq+PP8K0KUlRWHCk3BWgpviP+bjmp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=CTLQDGbX; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 12BBE177103; Fri, 18 Oct 2024 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729269096; bh=iznIP1CQ2RKWwk7uUDU5rLTH1EXRc5AplndOTJbAEBA=;
	h=Date:From:To:Subject:From;
	b=CTLQDGbXDkiBfolwG5yy1jOH2Fff+uvYjb1Is94eWi1LnmBIfpW/BXWbxqIeK6yNB
	 fydZIRBikSeJ054rYODTynf2YWUhSukOEh11jo+icPGS/kaJ0KkZkYGkSz8kuZp4Z0
	 Nlm5B6df1mx4KIl7Q5RTiHYn9scohtbjyUVOdt7SslQEmwvt6z8KFCXv34BAw4Fw+e
	 1yJW6NybxKZsWNqXCol9MsZ9pVOJjbTsTNOTv47aztpAble7lob+EsjsRhUnsubhig
	 wEQGOGXFySGsB5DCV6QZWccTX8xi1YW1fBUVjzWbsbreSSMfO1ZjxVvTP10KApva0v
	 cU/X1MBm6ihyw==
Date: Fri, 18 Oct 2024 16:31:36 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: English fixes in kgdb/kdb article
Message-ID: <20241018163136.GA795979@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
+Next you should choose one of the I/O drivers to interconnect the debugging
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
+At run time you can enable or disable kgdboc by echoing the parameters
 into the sysfs. Here are two examples:
 
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

