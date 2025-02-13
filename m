Return-Path: <linux-kernel+bounces-512334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D4A337B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883A4168B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F35206F0F;
	Thu, 13 Feb 2025 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="p2iNpECG"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3814F9D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426748; cv=pass; b=ub2O4IDzuFnIzNqD5GfUknVvAwwDJRV0SpA+/9v7RMa9gkdtQ/tIAMytevxYbdiDDriuLwOBdASPyXmsMm+jLxYf5Zb9xAsXItSkQaIwJMuScxRYBBOLtrwoveFC20Xj+DzTS8kLELcHhyXJmQP/Li1Nuwbo9p7pkNM7zQ5uYIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426748; c=relaxed/simple;
	bh=ZxZ7yIDRNJAgWbQ5GgsBn7MOoc4zESUrMj92p2KKbqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGqW6OMvaKXAsJWfUGrnwoKckHclqNnq4Fh/yf2lBoOa3wEt3rfWEoAWyAa/37fc3mfDu9P+ttYzOybINKvwNv5K39XprYxY3+CBA5342o9kaYtN3DO7AM3Bn61fhTdWXWe+RgSsW8ukFB/prmVRP7nqIQ6x4iOVHZTiCW5G9Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=p2iNpECG; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1739426735; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SOE4TRFa2TT1u+QYUl904QDNAiTtKmRuP2LuKhtVoIZm9/26nWXP0uNIf/7EplHZ2wWEbXJOEZcnQ5nwJzfnqVn4uoUva8Qj3U6trmxy6DkOhT9UH8fHTjHfWbyKW7BLhI9RPtopaIZ4+Nx1ofzSJNthdJtq5TCQi/EYgz/2fVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739426735; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZxZ7yIDRNJAgWbQ5GgsBn7MOoc4zESUrMj92p2KKbqY=; 
	b=PMf9kXUPIgWIeqe8DN3a0LYmfvR5Bun+o5s2amCVnX/tOCGytjVdLXGgtNwzHd8v7gdXet+rOiCbuXfFSQCpj5M1YTn8/dmrlCj/4PcL+RRLpe1R0R+U3PUvolwLMLIah4NUt9CQ0MTIlgpd7N+f3VAJp0wexovbENlVz9LQbCw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739426735;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ZxZ7yIDRNJAgWbQ5GgsBn7MOoc4zESUrMj92p2KKbqY=;
	b=p2iNpECGvV1yMkGWzjXYgatN8kdiskF42X4Mxa7FeCj+8TZ+VGtGrLi0EvxC2GfV
	A6hD7pdqN0zvFv3gAyUB8IdvUFEO9JRbCo9Jw64V4TkDjiwlOCg97onNIIK01Xn4Xg+
	PjBzBE5vG3OtUN5UweDcXOESpN58suVA96IdDmmSf0/G3DDtt1mjWBazJ7xNd3x2FNz
	rkxC+wjf1Siq+BB4HN997R+Ru9jzPJX/JEGyK7On9pxfQtoinlziwkaE0mC8McYKHYL
	e31hNq7w0YdTWZ4qIBg6YhjzIrcCseuM0QROStRHZyB/LhWYOThSG7zG4Olsfgsyrmx
	VBToN6zLLA==
Received: by mx.zohomail.com with SMTPS id 1739426734227256.68236209443637;
	Wed, 12 Feb 2025 22:05:34 -0800 (PST)
Message-ID: <150c3e85594e6256d4f3254bd4ef597612cf8428.camel@icenowy.me>
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
From: Icenowy Zheng <uwu@icenowy.me>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 14:05:29 +0800
In-Reply-To: <20250213055449.GB19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me>
	 <20250213055449.GB19370@lst.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-02-13=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 06:54 +0100=EF=BC=
=8CChristoph Hellwig=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> > Here is a small patchset that is developed during my investigation
> > of
> > a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> > SSD), which is because of the SSD's too-small CMB block (512KB
> > only).
>=20
> Hah, that's certainly and odd CMB configuration.
>=20

Sure, maybe it's just intended for a little queue. Register 0x38 value
is 0x00000004, Register 0x3c is 0x00080001, and BAR 4 is 64-bit
prefetchable memory with size=3D512K. I tested writing arbitary data to
the BAR 4's first few words and it correctly retains (which means they
seem to be really memory instead of registers).

I saw some mention of support CMB for submission queue in the brief of
Intel D3700/3600, maybe this applies to D450x as a successor?

BTW I am not sure about the relationship between Intel D series and P
series SSDs (only knows that D series is for dual-port redundancy), and
I have a P4511 as my boot disk (D4502 is data storage), which comes
with no CMB at all. (P4511 and D4502 shares PCI ID, but not PCI
subsystem ID).

