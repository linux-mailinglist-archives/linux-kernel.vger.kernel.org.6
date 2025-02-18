Return-Path: <linux-kernel+bounces-520287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1633A3A7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828B51738E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59C1E835C;
	Tue, 18 Feb 2025 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mVv+dzha"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224521B9E8;
	Tue, 18 Feb 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908241; cv=none; b=LU5UvKIOchV2bCACDIBNgJqjpHAB4aTOHpavEvx2lkDpd9xyT+sZDvigIeDEFchLpjwCeUo5d54rZFeysJ0/7K6lM2MTH0Y/JCbK4032v3x0CuUKO9R9PCr3cbSALJlFfR0AbbITAGNqPNSl0BIrdk0/KLMDtEqH6YbbiiCTfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908241; c=relaxed/simple;
	bh=vRF9TEvwV6fSl/fkAGhEb8RPPyMhw3ol/kslpsH1PWE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=P6wyNDFSmC5FwJF/dgJJzSvIoNxsF4RIsjLG9XrtH/uLMtUR3JpcGDmW5yhKKHiLt1Cj19b6TJ/iokkrk1t1U73FoPaMTX/swBCPyu4z0U4i5f51xiUfkjUzGu6P0LnxMbZ8/61NSgZfFt7IBPF/KOOM55+VMFbVMifg2ZUFkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mVv+dzha; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=c1sk8iljrl1m+r2dZCO0bLxoLdDjULSghW51Pq9XZ8I=; b=mVv+dzhazLyTBT6qAVaBuUYO67
	GhNT4+pUyh9zgctX/oq1m2G4kaxj+lO1tvSttqF3+4HB3lRA7esgcE5J3Fjk/WtQoBrvOOvmFSYd5
	5RHY3YJt1VeAG6S0CJFn3nHSeiaTYBZrNiz3jw1W3+AKtnHjVcJttEuYFckcK5UNEtF56A7ig793R
	nbXOKPtJiHigSxxOKsWm8e2pi5GKbH/G5oPAri+sHeg1YRWFfHDZ0Umim8aZb4qUOOwb8pNb0z6Dt
	mvwmi2+vOZJok+7kgoI40HSzgZc2hIDnpSZZjM4Vxldy1OiNVZiY8ztDnpw0GCsSjIUyGyZQJZK6K
	V/VPM9qg==;
Received: from [129.95.238.77] (helo=[127.0.0.1])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkTc1-00000003jhW-3ca4;
	Tue, 18 Feb 2025 19:50:34 +0000
Date: Tue, 18 Feb 2025 11:50:32 -0800
From: Randy Dunlap <rdunlap@infradead.org>
To: Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Documentation/kernel-paramete?=
 =?US-ASCII?Q?rs=3A_fix_typo_in_description_of_reserve=5Fmem?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250218070845.3769520-1-rppt@kernel.org>
References: <20250218070845.3769520-1-rppt@kernel.org>
Message-ID: <98FDFEF0-7CED-41AF-88DD-590A9846C03F@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 17, 2025 11:08:45 PM PST, Mike Rapoport <rppt@kernel=2Eorg> wro=
te:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel=2Eorg>
>
>The format description of reserve_mem uses [KNG] as units, rather than
>[KMG]=2E
>
>Fix it=2E
>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel=2Eorg>

Acked-by: Randy Dunlap <rdunlap@infradead=2Eorg>

Thanks=2E

>---
> Documentation/admin-guide/kernel-parameters=2Etxt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters=2Etxt b/Document=
ation/admin-guide/kernel-parameters=2Etxt
>index fb8752b42ec8=2E=2Ebf00552908bc 100644
>--- a/Documentation/admin-guide/kernel-parameters=2Etxt
>+++ b/Documentation/admin-guide/kernel-parameters=2Etxt
>@@ -6082,7 +6082,7 @@
> 			is assumed to be I/O ports; otherwise it is memory=2E
>=20
> 	reserve_mem=3D	[RAM]
>-			Format: nn[KNG]:<align>:<label>
>+			Format: nn[KMG]:<align>:<label>
> 			Reserve physical memory and label it with a name that
> 			other subsystems can use to access it=2E This is typically
> 			used for systems that do not wipe the RAM, and this command


~Randy

