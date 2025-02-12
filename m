Return-Path: <linux-kernel+bounces-511818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE84A33020
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16094162185
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837C20102A;
	Wed, 12 Feb 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVoxhRzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8320013A;
	Wed, 12 Feb 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389801; cv=none; b=P8j9f2lC1qFY/Tqp1juPcsFeS979Yr9McT2PzHq6rnbeZE8IlZN1/knrgaRrjwERi+71Dr67abdge+FWizNl3reFnQeitUmkU7EvSCGtRVxnuvBJgSdRWS2qJYShilSB7D4vegtJiJjThvQBo9puEFhoFAZtdzeEwOu1TZQeaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389801; c=relaxed/simple;
	bh=qRczGa8mUmvt/RUG4HaVJ427lqSU37GvFDIl21GUKq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg52cMk+heXnq5EHE7X0cTW0d0mcOhJ3HQxtqOWT1N5236Kcd19mp6CvhBoB/6nF1+PFujQvhxR1c8WSITSpULdzk91/UinCIhokrQ9XOcfS3TMZz8dqjoc5ZfFBzngxpTfgMK0PLUoR0M28WiDS8PyMVU8TDNDm9HBKMCcsE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVoxhRzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D8C4CEDF;
	Wed, 12 Feb 2025 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389800;
	bh=qRczGa8mUmvt/RUG4HaVJ427lqSU37GvFDIl21GUKq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVoxhRztG/7//AGN49krym+TNi1s+LJrQAM3HqpwsIdS7G6ZU4qfY0pkU/3oTB/Mm
	 q1WSheZPe1Xux3gDHC6gsAIwhfN2DXhCTgs6//19+ebMgvfeR7GAZ9I944iXdWsyRk
	 BlfrQZPoevzWpmdXoNKaVESbxF2UwOxar+x4foMyZrJU+kadCPnvJwOmnCZ98HaFem
	 bBIlKBSvgcMIeYJHzmQW0Rvkqv+M7fC1iTHjb228tDM/90y7751VxV+u6ceuAEwjSV
	 uIQXjug9OhPMZAZtnIfNW0WHwDLp7k6GveCam1JjAb1t3eZ0XahFNxIXUvh/gpjxm3
	 6/Q9CWb5cqVKg==
Date: Wed, 12 Feb 2025 13:49:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Longbin Li <looong.bin@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: reset: sophgo: Add CV1800B support
Message-ID: <173938979936.135912.2099635079026768337.robh@kernel.org>
References: <20250209122936.2338821-1-inochiama@gmail.com>
 <20250209122936.2338821-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209122936.2338821-2-inochiama@gmail.com>


On Sun, 09 Feb 2025 20:29:32 +0800, Inochi Amaoto wrote:
> Add bindings for the reset generator on the SOPHGO CV1800B
> RISC-V SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/reset/sophgo,sg2042-reset.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


