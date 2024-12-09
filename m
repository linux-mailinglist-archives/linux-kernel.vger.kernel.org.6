Return-Path: <linux-kernel+bounces-438354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15D9EA00D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B794A2828E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102119994F;
	Mon,  9 Dec 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nyw7V+wJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC8184556;
	Mon,  9 Dec 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774836; cv=none; b=mMRSTZBrr2Eq82KVMzQmZ3tGXM8eGjGvxHidf3h1pQ4K1YXUgkB3TaG4fzUoj/X5zSzZ6NONCgYBRWiXnbUCtqJh2mcuS/X8A8BttHtXNn0JGjSBLJbZP2LiYCjuFAg2pCWxwMKthrYliYbFV8U9gpxDE0H8gpZsCBhwQ24/5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774836; c=relaxed/simple;
	bh=XHeeybhj5u2b8BHEtLKC3hKJSOqzRrrU3o97MCDUjaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omd/SPynFxBSvUJp70650clIZi1pzwfANexJeML5XgD2+8pdt+k/Eh2BYZtuP0LWyj+JAK68CR2aHYy72zMmOFks2WdAI9K/5T8Y9LRsM/pS73H/RLNkcBsu/Qrx7dicC4TfoBZ/tmKWrFjbSiOsTexVJKG2pnQH3KqvtprCgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nyw7V+wJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733774832;
	bh=XHeeybhj5u2b8BHEtLKC3hKJSOqzRrrU3o97MCDUjaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyw7V+wJ6jSPe9lIbRvVSihwC0AUWedhKPy2iBGsL6d971k2Cv/6CqVfA/rn9pXks
	 GBLlqwLP+A+/gTn2Jlcep+CcN23rMmWU59KIeTpaDotz36jkfIzLUCetGU3u8pbAkH
	 qEbiY/V9XJzWNyRKgF7flBQzbgxX0IVSycXr8NuBSqy5s4Nu+Ckud/8es/Fo2XZXrj
	 FdHnxO72b+zm+J0v+pY7g8efUsCJqg2IIL+B56F5EvmlqmviWYfnvXIk+M9ZdJ+sMx
	 JohnjPIyfrrjjCdyMglpioyR3Cjm4axQZ0pNNoXvTV/A7WkaW7ua0Uo20pFpZfkUDx
	 XIBVs/9OzxmpQ==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0F5A17E3780;
	Mon,  9 Dec 2024 21:07:09 +0100 (CET)
Date: Mon, 9 Dec 2024 17:07:07 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Trevor Wu =?utf-8?B?KOWQs+aWh+iJryk=?= <Trevor.Wu@mediatek.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Message-ID: <108d4187-26af-43f6-8b1e-0e48516524a4@notapiano>
References: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
 <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
 <a70a0521-985d-43a4-a1fa-36eb733d5ca9@collabora.com>
 <1d2ee55dde84bcab6f777525042c6789b9f2c1fc.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d2ee55dde84bcab6f777525042c6789b9f2c1fc.camel@mediatek.com>

On Fri, Dec 06, 2024 at 06:57:00AM +0000, Trevor Wu (吳文良) wrote:
> On Thu, 2024-12-05 at 13:51 +0100, AngeloGioacchino Del Regno wrote:
> > 
> > 
> > Il 04/12/24 13:17, Trevor Wu (吳文良) ha scritto:
> > > On Tue, 2024-12-03 at 17:07 -0300, Nícolas F. R. A. Prado wrote:
> > > 
> > > > 
> > > > Currently, booting the Genio 700 EVK board with the MT8188 sound
> > > > platform driver configured as a module (CONFIG_SND_SOC_MT8188=m)
> > > > results
> > > > in a system hang right when the HW registers for the audio
> > > > controller
> > > > are read:
> > > > 
> > > >    mt8188-audio 10b10000.audio-controller: No cache defaults,
> > > > reading
> > > > back from HW
> > > > 
> > > > The hang doesn't occur with the driver configured as builtin as
> > > > then
> > > > the
> > > > unused clocks are still enabled.
> > > > 
> > > > Enable the apll1 clock during register read/write to prevent the
> > > > hang.
> > > > 
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > >   sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > index
> > > > e69c1bb2cb239596dee50b166c20192d5408be10..fb8cf286df3f02ac076528b
> > > > 898f
> > > > d0d7a708ec1ea 100644
> > > > --- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > +++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > @@ -587,6 +587,8 @@ int mt8188_afe_enable_reg_rw_clk(struct
> > > > mtk_base_afe *afe)
> > > >          mt8188_afe_enable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_AUD_A1SYS_HP]);
> > > > 
> > > >          mt8188_afe_enable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_AUD_A1SYS]);
> > > > 
> > > > +       mt8188_afe_enable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_APMIXED_APLL1]);
> > > > 
> > > > +
> > > >          return 0;
> > > >   }
> > > 
> > > Hi Nicolas,
> > > 
> > > If I understand correctly, APLL1 should be the parent clock of
> > > AUD_A1SYS_HP and AUD_A1SYS, so it should be enabled automatically
> > > by
> > > CCF.
> > > 
> > > I'm not sure why you resolved the hang issue after enabling APLL1.
> > > Could you share more details about the solution?
> > > 
> > 
> > Hmm. Now I see what's happening here...
> > 
> > Nicolas, Trevor,
> > 
> > Possible parents for top_a1sys_hp are:
> >   - clk26m
> >   - apll1_d4
> > 
> > ...what's happening here most probably is that after the clock gets
> > disabled as
> > unused, it gets parented to clk26m by default as that is parent index
> > 0... and
> > something else in AFE needs APLL1 to feed a clock to .. something ..
> > to allow
> > register access.
> > 
> > Trevor, do you know why is this IP unaccessible when A1SYS is
> > parented to clk26m?
> 
> Hi Angelo,
> 
> As far as I know, it should work even though the clock is parented to
> clk26m.
> 
> Unfortunately, I have no idea about why APLL1 enabling can resolve the
> hang issue. I'm also curious about how Nicolas found the solution to
> resolve the problem.
> 
> From the description, it seems that the problem is related to register
> r/w hang. If I remembered correctly, when the mtcmos of ADSP_INFRA is
> ON, register r/w won't cause the cpu to hang. However, ADSP_INFRA has
> been configured as ALWAYS_ON in the driver. I'm not sure if it doesn't
> work correctly when the driver is configured as a module. Maybe Nicolas
> can also check this.

Indeed, as suggested by Angelo, adding 

  assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP>;
  assigned-clock-parents = <&topckgen CLK_TOP_APLL1_D4>;

to the afe node also fixes this issue. 

In mt8188.dtsi, we currently have

  afe: audio-controller@10b10000 {
  	...
  	assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP>;
  	assigned-clock-parents =  <&clk26m>;

So the question is, do other MT8188 platforms need clk26m to be the parent of
a1sys_hp? Depending on that I can either update the parent on the common
mt8188.dtsi or on the genio700-evk.dts, which is where I observed the issue. I
don't have access to other mt8188 platforms. Trevor, do you know?

As for how I identified this issue, I noticed that when booting with the
platform driver as a module the system would hang, and that passing
clk_ignore_unused avoided the issue. Then I selectively ignored some unused
clocks until I narrowed down to ignoring unused only the apll1 clock, meaning
the apll1 clock needed to be left on during the platform driver probe for the
system to not hang.

Thanks,
Nícolas

> 
> Thanks,
> Trevor
> 
> > 
> > That might give Nicolas a definitive hint about how to resolve this
> > issue.
> > 
> > Cheers,
> > Angelo
> > 
> > > Thanks,
> > > Trevor
> > > 
> > > > 
> > > > @@ -594,6 +596,8 @@ int mt8188_afe_disable_reg_rw_clk(struct
> > > > mtk_base_afe *afe)
> > > >   {
> > > >          struct mt8188_afe_private *afe_priv = afe-
> > > > >platform_priv;
> > > > 
> > > > +       mt8188_afe_disable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_APMIXED_APLL1]);
> > > > 
> > > > +
> > > >          mt8188_afe_disable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_AUD_A1SYS]);
> > > > 
> > > >          mt8188_afe_disable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_AUD_A1SYS_HP]);
> > > > 
> > > >          mt8188_afe_disable_clk(afe, afe_priv-
> > > > > clk[MT8188_CLK_AUD_AFE]);
> > > > 
> > > > ---
> > > > base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
> > > > change-id: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-
> > > > b3c11782cbaf
> > > > 
> > > > Best regards,
> > > > --
> > > > Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > 
> > > > 
> > 
> > 

