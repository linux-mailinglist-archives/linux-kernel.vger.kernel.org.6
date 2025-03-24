Return-Path: <linux-kernel+bounces-573189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE53A6D402
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FAC16CC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4A18E76F;
	Mon, 24 Mar 2025 06:07:03 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E05130AC8;
	Mon, 24 Mar 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796423; cv=none; b=jVmGHnMWISt8g+8JcmTpX7sncuyq2Ueg2EJh6yikRTo6xpQo/gmb2vAHdk5ddFK447NeyzgvjcRhibxVheiKxN1ai2GB0uD0rp5EIPfockyqr1yOGVYeXKSx6vo6kQn+MMW6G+Ki3G2hNo4Y63QE5ujlGUxv2YBuVhrE1GUeEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796423; c=relaxed/simple;
	bh=Qo1ZzOp+qIGtCdYkQjGaL8gkmFFkTlO4yGdZmiKINGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXlqx6wq19btwiSXEgxB5xoVrthbJP32s7s5kScYvV6PvlxXbpxKchG5VxDoyPNKWgc21rj1+NFf2QJxv0wr0/4D5bk7UCHICzNERRjz34F1WHH1cjRs7G9aR9/diesdLD4/gIsuu9dx0zQBoxGZkca71dkInh9Oc7VSAVKIMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 247763432FE;
	Mon, 24 Mar 2025 06:06:57 +0000 (UTC)
Date: Mon, 24 Mar 2025 06:06:53 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 7/7] riscv: dts: spacemit: add reset support for
 the K1 SoC
Message-ID: <20250324060653-GYA18687@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-8-elder@riscstar.com>
 <20250322164830-GYE11633@gentoo>
 <b5af3a7a-c5da-497a-ad67-c99edfdf665e@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5af3a7a-c5da-497a-ad67-c99edfdf665e@riscstar.com>

Hi Alex:

On 08:23 Sun 23 Mar     , Alex Elder wrote:
> On 3/22/25 11:48 AM, Yixun Lan wrote:
> > On 10:18 Fri 21 Mar     , Alex Elder wrote:
> >> Define syscon nodes for the RCPU, RCPU2, and APBC2 SpacemiT CCUS, which
> >> currently support resets but not clocks in the SpacemiT K1.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >>   arch/riscv/boot/dts/spacemit/k1.dtsi | 18 ++++++++++++++++++
> >>   1 file changed, 18 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> index 09a9100986b19..f86d1b58c6d35 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> @@ -350,6 +350,18 @@ soc {
> >>   		dma-noncoherent;
> >>   		ranges;
> >>   
> >> +		syscon_rcpu: system-controller@c0880000 {
> > I'm not sure if syscon_rcpu is good name to go, it's AUDIO Peripherals
> > in docs, see
> > 
> > 7.2 Main CPU Domain Address Mapping
> > https://developer.spacemit.com/documentation?token=LzJyw97BCipK1dkUygrcbT0NnMg
> 
> They call it "AUD_MCUSYSCTRL section <RCPU(0xC0880000)>",
> where the registers layouts are defined, and the register
> names use the "RCPU" prefix by convention.
> 
> I guess I could use "AUDIO" instead, but I think it's
> "RCPU" is a little better because of the way things in
> the region are named.  It's a little like how "pll" is
> used for the DT node name for things in the "APBS" region.
> I don't really like that, because the connection between
> the two isn't very clear.
> 
ok, by whatever you choose, I'd be fine
in case you go with RCPU, can you put a comment above? explain
there is slightly a devergence with docs from SpacemiT's web

also I noticed the io size you written here is smaller than described in
docs which I think usually it's fine (docs may give larger number - 0x80000)
just make sure you checked? so all real io region will be covered, same
for rcpu2

> >> +			compatible = "spacemit,k1-syscon-rcpu";
> >> +			reg = <0x0 0xc0880000 0x0 0x2048>;
> >> +			#reset-cells = <1>;
> >> +		};
> >> +
> >> +		syscon_rcpu2: system-controller@c0888000 {
> > not found this address mapping in above docs link
> 
> You're right.  I was following what the downstream code did.
> I'll gladly just include this in the main "RCPU" node.
> 
> Thank you very much for the review Yixun.
> 
> 					-Alex
> 
> >> +			compatible = "spacemit,k1-syscon-rcpu2";
> >> +			reg = <0x0 0xc0888000 0x0 0x28>;
> >> +			#reset-cells = <1>;
> >> +		};
> >> +
> >>   		syscon_apbc: system-control@d4015000 {
> >>   			compatible = "spacemit,k1-syscon-apbc";
> >>   			reg = <0x0 0xd4015000 0x0 0x1000>;
> >> @@ -518,6 +530,12 @@ clint: timer@e4000000 {
> >>   					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> >>   		};
> >>   
> >> +		syscon_apbc2: system-controller@f0610000 {
> >> +			compatible = "spacemit,k1-syscon-apbc2";
> >> +			reg = <0x0 0xf0610000 0x0 0x20>;
> >> +			#reset-cells = <1>;
> >> +		};
> >> +
> >>   		sec_uart1: serial@f0612000 {
> >>   			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> >>   			reg = <0x0 0xf0612000 0x0 0x100>;
> >> -- 
> >> 2.43.0
> >>
> > 
> 
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

