Return-Path: <linux-kernel+bounces-439672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DA9EB271
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9528286C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D741AAA28;
	Tue, 10 Dec 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="r/8E9EC6"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A01AAA11;
	Tue, 10 Dec 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839168; cv=none; b=iuRwmwtirl3CGZdYT7xUMjvZZWYNvBTdG274JjaSanTIKUUNfwCejt5ez5M52Ru8sTZpB6pOxBGmC4Qt3Dev45UKIOFvcApg5lll4NzcKoBWiY1uHWHj6M1jnbwuFDs934sXWIS/iCLsTdCXYRdeOFDZ+jY2YYuq4fGohGAGD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839168; c=relaxed/simple;
	bh=4sX1Ezr0RC74ZXIGGmUZqb6ej+0p+Fxoey9HO6F0EtQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mEGJTRkjY7jDju7s/cv1KAFzVWHFtt8LWvZEYxIRoYL3H9vCfTJiyrujUWZErS18wrk78OqK5Gn8HlguFgUsYr1hnADoczLU8YvsEiLeCx2jcqvFAbwLITjm5QOoXrTw3cC9NULZWoPBIWPK7Gt0Y62vDPjhJoWnkkSgVp1Ilyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=r/8E9EC6; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733839164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGtCSR7EeU4PQbry3weYc55FRPjXetuC+CXU0b67FGM=;
	b=r/8E9EC6TV/aMV/96LuAUOyPdx+bIPuJE6ANGTFf2tdpwYfvhMz2NbAanz1XEQGvfgI5DH
	pBlpCmOH7yIqG9sXrjxWxspNIuPhBoSNVhij7YLVT2W05+I2hL8KEKAtgKh3qCUy5ZJayM
	G5bXalU+rQ4kytfHZlrYZ4qCqvtkFFRhx8XPQrtf6wsX/6Osm4KZ6x8j+0DOoAD+dqwQUk
	4nVfgMNOA5p0AS/T55BZQ4H0kN7WIS6Wqi7F1orbxTX3wrTeEU6jK7WJNdTrsb1lEbk+8h
	m7oFqofKVDEgJRWswfF4BgOxiM8IXmODZGpAe0kPJu3dZl+xq/IGuKNAxXjwzQ==
Date: Tue, 10 Dec 2024 14:59:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang
 <zhangqing@rock-chips.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/6] clk: rockchip: fix wrong clk_ref_usb3otg parent for
 rk3328
In-Reply-To: <CAMdYzYqJLK6oJHCUVztth6mtJsYrRQSPzNYpR-ZmR7rNprZXfg@mail.gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-3-pgwipeout@gmail.com>
 <0d11705121f29ccfb7cfa342505a6e35@manjaro.org>
 <CAMdYzYqJLK6oJHCUVztth6mtJsYrRQSPzNYpR-ZmR7rNprZXfg@mail.gmail.com>
Message-ID: <bcc296ea8c15eddce62a8d3ef3a509b7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 14:27, Peter Geis wrote:
> On Tue, Dec 10, 2024 at 4:44 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-12-10 02:30, Peter Geis wrote:
>> > Correct the clk_ref_usb3otg parent to fix clock control for the usb3
>> > controller on rk3328. Verified against the rk3328 trm and usb3 clock
>> > tree
>> > documentation.
>> >
>> > Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
>> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>> > ---
>> >
>> >  drivers/clk/rockchip/clk-rk3328.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/clk/rockchip/clk-rk3328.c
>> > b/drivers/clk/rockchip/clk-rk3328.c
>> > index 3bb87b27b662..cf60fcf2fa5c 100644
>> > --- a/drivers/clk/rockchip/clk-rk3328.c
>> > +++ b/drivers/clk/rockchip/clk-rk3328.c
>> > @@ -201,7 +201,7 @@ PNAME(mux_aclk_peri_pre_p)        = { "cpll_peri",
>> >                                   "gpll_peri",
>> >                                   "hdmiphy_peri" };
>> >  PNAME(mux_ref_usb3otg_src_p) = { "xin24m",
>> > -                                 "clk_usb3otg_ref" };
>> > +                                 "clk_ref_usb3otg_src" };
>> >  PNAME(mux_xin24m_32k_p)              = { "xin24m",
>> >                                   "clk_rtc32k" };
>> >  PNAME(mux_mac2io_src_p)              = { "clk_mac2io_src",
>> 
>> Sorry, but I was unable to verify this in the part 1 of the
>> RK3328 TRM, in both versions 1.1 and 1.2, which is all I have
>> when it comes to the RK3328 TRM.  Is that maybe described in
>> the part 2, which I've been unable to locate for years?
>> 
>> Moreover, the downstream kernel source from Rockchip does it
>> the way [1] it's currently done in the mainline kernel, which
>> makes me confused a bit?  Could you, please, provide more
>> details about the two references you mentioned in the patch
>> description, or maybe even you could provide the links to
>> those two references?
>> 
>> [1] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/refs/heads/develop-4.4/drivers/clk/rockchip/clk-rk3328.c
> 
> It is unfortunate the TRM doesn't include the clock maps, because they
> are extremely helpful when one can acquire them. It also doesn't help
> that the TRM register definition only referred to this as "pll". I was
> sent specifically the usb3 phy clock map for my work on the driver,
> which had the location of each switch and divider along with the
> register and bit that controlled it. That combined with the TRM
> register map allowed me to find this error.

I see, thanks for the clarification.  I'd assume that you aren't allowed
to share the additional documentation you've got, which is unfortunate,
but it is what it is.  We should be happy that at least you got it, and
were able to put it into good use.

Thanks for fixing this!

