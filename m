Return-Path: <linux-kernel+bounces-241996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A996928253
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266D528342D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA10144D0F;
	Fri,  5 Jul 2024 06:50:01 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D213DDD0;
	Fri,  5 Jul 2024 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162200; cv=none; b=X6sQlEKJUbxXLFcJCXUYTOxg+pCqcBz2sCDFeZf8Acoip0Q28OQKQRl9sgdW6aaq6pohTjQULGLrrqwf+ptSx88U5QNfi4fQC2bHRIKYBZvxYHsGXm2mSTYOJkFvmfPJTnq5n0GhvXhBr2XsJmYmCL/HBU+wbK5K1osNpr+EBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162200; c=relaxed/simple;
	bh=Pje75fQrugDDHhA7sDPEh8+u2gaMunb6yEOU7yVZo5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvxbiaVXP6Nz06kPsPk9T60kxBLt1p8YGdpIEOyCo6jhVYUum/7fuG6NYs5srFl4dJS2qzhoOW0K8i6P5GhJBqPUGQ966gWpm4bCk7fDqo9slD1Uh3pFMvQMIP5x1hAToqex3WTzGiy3Ou3jT1d8dsrPnHIh4H05l1U0SvzEISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 5 Jul 2024 06:49:54 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>
Subject: Re: [PATCH v3 11/11] riscv: dts: spacemit: add uart1 node for K1 SoC
Message-ID: <20240705064954.GA3034508@ofsar>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-11-12f73b47461e@gentoo.org>
 <ZoasDzbOfQjxk9QZ@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoasDzbOfQjxk9QZ@xhacker>


On 22:05 Thu 04 Jul     , Jisheng Zhang wrote:
> On Wed, Jul 03, 2024 at 02:55:14PM +0000, Yixun Lan wrote:
> > Devices in 0xf000,0000 - 0xf080,0000 are reserved for TEE purpose,
> > so add uart1 here but mark its status as reserved.
> 
> This patch doesn't deserve a seperate patch, it's better to fold it
> into the dtsi one.

fine, I will address it in next revision

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

