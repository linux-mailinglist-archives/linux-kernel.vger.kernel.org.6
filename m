Return-Path: <linux-kernel+bounces-547357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F52A5063A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F5517040C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B11C860B;
	Wed,  5 Mar 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npHNn9Hm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0374170A13;
	Wed,  5 Mar 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195046; cv=none; b=BN4P5aVLuNgnTJJwSWioyc6K7BQUlZOZVk+j2t0MFISSrLGEBWbXZgghMMAHcZhBXMf+23Sllc8h21+64Fu1bH45HeB1TCMbgq8dRJeTncMkBny45XU3JW49ZvR+uzSYxHgZOqB3/ou5ZORDgdR00HBalCkMvXDL7dHbVda+ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195046; c=relaxed/simple;
	bh=XJWPRUoTb/Vx4G3uOprbaaDyJtXhaxTE+VvpTzPkG1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8p3fE7fF8qLodaPDhZgaWhTV3zkzRfaprgU8cI7p78LhnVuMFQQAdHimUMalKVdOWzd4V0/4LKtz1FCJRhqMq7YHZhLLUXM961uIzeki6bPTfZZcozbukEjfn4aL1/IncGpRYfXP1B3CN1I8QsM+CpxUteJdOqsii4uLBa3iX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npHNn9Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA68C4CEE2;
	Wed,  5 Mar 2025 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195046;
	bh=XJWPRUoTb/Vx4G3uOprbaaDyJtXhaxTE+VvpTzPkG1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npHNn9Hmu0fwIcubnTn9GlArjuS6TL3Le08tOoG0Soe9wBKd4EwVUMJeSv1U/jb1W
	 6OCxCiDHqv82nOa7lFPKLlhLWpXaznbxEzkzosghO/Ep3XnyBy268838yYrLQrV5he
	 6qFNHtJKRh17Au2J7AzpWsefiGnQlPD8xPi42tugTUNry9eFcMg/rBYk4Ol5jwEOIn
	 tWkn0ltdEVZGNOm+bO8l4j4/lee8wIG453yx7V1KOpTQdsRz/g9wf+LoTodjlhLzBn
	 FAYuhG1isYF30vh/OBCBN/Ni5/Gg0tkMJKZmO4OM9xMjzuKPZ+ER/mr2w23ce78c1q
	 CKrpbE9CDpOIQ==
Date: Wed, 5 Mar 2025 11:17:24 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Yao Zi <ziyao@disroot.org>,
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
Message-ID: <20250305171724.GA2149138-robh@kernel.org>
References: <20250305140009.2485859-1-amadeus@jmu.edu.cn>
 <20250305140009.2485859-2-amadeus@jmu.edu.cn>
 <52155b03-20f3-4e64-b636-70042db03ffa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52155b03-20f3-4e64-b636-70042db03ffa@kernel.org>

On Wed, Mar 05, 2025 at 04:41:23PM +0100, Krzysztof Kozlowski wrote:
> On 05/03/2025 15:00, Chukun Pan wrote:
> > Copy QoS nodes and add rk3528 compatible from bsp kernel,
> 
> No, don't copy stuff from BSP kernel. It results in terrible DTS.
> 
> > these can be used for power-domain.
> > 
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 160 +++++++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > index 5b334690356a..794f35654975 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > @@ -122,6 +122,166 @@ gic: interrupt-controller@fed01000 {
> >  			#interrupt-cells = <3>;
> >  		};
> >  
> > +		qos_crypto_a: qos@ff200000 {
> > +			compatible = "rockchip,rk3528-qos", "syscon";
> > +			reg = <0x0 0xff200000 0x0 0x20>;
> > +		};
> > +
> > +		qos_crypto_p: qos@ff200080 {
> > +			compatible = "rockchip,rk3528-qos", "syscon";
> > +			reg = <0x0 0xff200080 0x0 0x20>;
> > +		};
> 
> 
> Did you just define syscon per few registers? Third case last weeks...
> so no, define what is your device here. 8 registers is not a device usually.

Well, it is just a new compatible on top of existing 'qos' compatibles.
And in a quick scan I didn't see other things adjacent. 

