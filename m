Return-Path: <linux-kernel+bounces-445872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC0A9F1CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0237A04E4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392214884D;
	Sat, 14 Dec 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/u8ujv6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD845023;
	Sat, 14 Dec 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734155903; cv=none; b=gYwxzVnQKzEMDxtF52ybnmYXpcOit3ARW81SYxASGeL5bbJGOpxUqoIFNAe3PnOrDLoLxdCMZjkvxkQZ/UULO+NgOvETisC3LNGnbpqoRGJVnbZK8oPTgYVoaerNet670KN8yMuK/rtgk7C+ixrkY8W2LGCL1qnd53E42sFCOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734155903; c=relaxed/simple;
	bh=+0dmmhWV01xzm3DpkY8gDJOKP6Sg225VSAqBRjFdri0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs0xSJFqaxhlSMLy08Hm+Zkp0j+za+ekhc74EAkGe3DDRRDR2gS9pu7YNdWvK75gSRDtAGsVk4L54OcQVCl4sD0ECmzS7GGmbv3AFOcr/yWMKxVF+wNtTljSIBWecD7V45tdiJY3r3txJCRw8RfpgFZ384S/qhabOi0z9rt3JmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z/u8ujv6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wpTwtGXygpmJk2bX9isiar0VjJreV5TrSzR3WoOJIoU=; b=Z/u8ujv6cOH+KzQfByiLAp2Ded
	fj939a+qCvhp8/eHneXf0/NTUtOtChr2PwtiJzhlVeLqnVOgOKwdBQM06MKj/Az3gOH0vq+C5uwgX
	zirooIRY/+eyDfumQ+cHW4VKiipjWyVW/VLivtVRWju9t2aOsLKdIcso8bVwdRI9CRT7zopoDXp1x
	3syaMIDbfpoJTSkCF/ODJG414Ob1ShnS5h2g3icD4NtTXphbYJLy8f4jSMTsnhx1UQkjKnajdzHlK
	LQGRFCgWvi/ShnNzm5DaZeF389p3BMRInwRV5RXem0Y1EK2E60L9M7J450X+GLRFMDXsMUprfj9A5
	9ZJh+SOA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLAK-00000004OqD-3buB;
	Sat, 14 Dec 2024 05:58:14 +0000
Message-ID: <97088fc4-04ab-47df-9a43-de2d36679f2d@infradead.org>
Date: Fri, 13 Dec 2024 21:58:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs: admin-guide: bring some order to the
 "everything else" section
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20241213182057.343527-1-corbet@lwn.net>
 <20241213182057.343527-4-corbet@lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241213182057.343527-4-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 10:20 AM, Jonathan Corbet wrote:
> The bulk of the admin guide had become a big pile of stuff haphazardly
> tossed together, mostly in the catch-all "everything else" section.  Split
> that section into a few broad categories and sort the documents into them
> as appropriate.
> 
> No documents have been added or removed, they are just reordered.  Note
> that many of these documents are severely obsolete and should be considered
> for removal.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/admin-guide/index.rst | 161 +++++++++++++++++-----------
>  1 file changed, 100 insertions(+), 61 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

