Return-Path: <linux-kernel+bounces-445343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035F9F14DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A5E16A8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC121E8854;
	Fri, 13 Dec 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FQujxeoo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27F1AC8B9;
	Fri, 13 Dec 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114091; cv=none; b=OMdCMyTGqXW3EOONg40dJUpHxH+YTwUjvC+MIy4DISoZBpGtedeOHYA576pK3qtq01nbTQCO4RQ92f18bHE0CCEo1PSkirWmt2JExesyLyQHe7Yd9EWJsmhziGF2ZJ/qi7XUadJ/m3Eo3hKyauOPXvOLwAQdLe4TMDWftkJvT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114091; c=relaxed/simple;
	bh=jm7N5YKqnQnD9VuuO+738auNMFHpTFzR2WtTBGXDk4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgE3KFbKGn9vyLrMAECxQPwXJqJkm2f9W7S83AqgYAyyHom7A7WiIFJPM3S5phTOJZzh9znXnutpq3XrO+xood97jNQmmHoYXlzsjwcV7DCHI4W534N2t8q9u/6nT+Mys8i0DKpPHeajy8RyklDAg14r7RCaTyUf0mipOL9lMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FQujxeoo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A6FF64040F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734114088; bh=4bzl5OvAbFEFDVzd4foCsplht08EqOXC8NWYSa15j/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQujxeoonO+ctAlaNftsh/fIQzhQ/5y6ZqaJItsEp78inbxMu7KOnAGK+wkDD0TvX
	 baJLbi7HCep6kFVKxidJnIdgqkrYntA4KPpLtfbNbugIL4Vg0hYNH4JjYA2lA2+bfU
	 S6xPqZHtvZWmJjTo2YjPWwoXWb1KnMuiu6wAPLqYy7bUEbI4eIh1Fez1HHpsNqh4QY
	 tPl7/F4mx0dLAKl7/EHA8ND+Xfav9+RZWt0fangamonb9TYukLgiRmqWpZoXac8UBX
	 7ZuFEK4xlL/xP1J2j61IpeXU3PDGAZGVrx1a5Ff7Tv5GVc9O6bJJgFb1j09BIZH/+Q
	 DC1U4LKldbtMA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:5e00:625::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A6FF64040F;
	Fri, 13 Dec 2024 18:21:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/3] docs: admin-guide: add some subsection headings
Date: Fri, 13 Dec 2024 11:20:53 -0700
Message-ID: <20241213182057.343527-3-corbet@lwn.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213182057.343527-1-corbet@lwn.net>
References: <20241213182057.343527-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As part of the goal of bringing some order to this file, add subsection
headings to help readers find what they are looking for.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/index.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 94b70bb203cc..6864b079b391 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -7,6 +7,9 @@ added to the kernel over time.  There is, as yet, little overall order or
 organization here — this material was not written to be a single, coherent
 document!  With luck things will improve quickly over time.
 
+General guides to kernel administration
+---------------------------------------
+
 This initial section contains overall information, including the README
 file describing the kernel as a whole, documentation on kernel parameters,
 etc.
@@ -28,6 +31,9 @@ This section describes CPU vulnerabilities and their mitigations.
 
    hw-vuln/index
 
+Tracking down and identifying problems
+--------------------------------------
+
 Here is a set of documents aimed at users who are trying to track down
 problems and bugs in particular.
 
@@ -48,6 +54,9 @@ problems and bugs in particular.
    perf/index
    pstore-blk
 
+sysfs
+-----
+
 A big part of the kernel's administrative interface is the sysfs virtual
 filesystem; these documents describe how to interact with sysfs.
 
@@ -57,6 +66,9 @@ filesystem; these documents describe how to interact with sysfs.
    sysfs-rules
    abi
 
+Workload analysis
+-----------------
+
 This is the beginning of a section with information of interest to
 application developers and system integrators doing analysis of the
 Linux kernel for safety critical applications. Documents supporting
@@ -68,6 +80,9 @@ subsystems expectations will be found here.
 
    workload-tracing
 
+Everything else
+---------------
+
 The rest of this manual consists of various unordered guides on how to
 configure specific aspects of kernel behavior to your liking.
 
-- 
2.47.1


