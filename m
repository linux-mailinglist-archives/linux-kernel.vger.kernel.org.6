Return-Path: <linux-kernel+bounces-186254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE18CC1C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0762845F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD148287F;
	Wed, 22 May 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AQYGwp3k"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DC82487;
	Wed, 22 May 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383227; cv=none; b=clueHUh+F7HfHWY67evClb7TubDSt4PBlM0SiPuY3aS3ZnYyI8Q39W3y1uBWusY1GQVUyjYVsIBYTLt37MojnWJoJ+/6OyuvJt+WnexfSBjzFL98PS1c/pxSiWy2yoilCY1y2gUo5IfU3PfDHaT2aofxwN39w4THMLCxgDY2tWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383227; c=relaxed/simple;
	bh=Jf8mZf3DgAaMtntKI4Uw9rXIc+EGLRwZMsKLOABmmPc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WG1yR5Q4HGtBxl3mlcWJj2S7jeMXZ4GqAPhYwDOhuNhoafrgCfjzlDKpDV5NFoeLBnDd1AkHqFHS4LDuGP7RJb05tM3VphqZcFCHWJkPxyj+dzeTP1Acm8L3Pa75OmfDoARY7bygqwG0bx7onZys9/TMCAweXn45Qwyvm8cWmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AQYGwp3k; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716383216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DKAHeVr2WZo8CYG+lRCuTrC6xOJJVRKKKaiTlSOfro=;
	b=AQYGwp3kldEn+VkmYCqm7oJKJuOTCUwP47m5XSPPaMNl7Z7HsSVDUBDheAUiAX+9gluhmo
	lByZtR2r3hSCUf/IZQ6lyK5cJsP/hJf3Gt1ibuotAmnPOBoG2QGAGeJXGB0Zky8d6pIjvF
	qlR4SCSruE9Kw08DPkq/8HvBOzY5+lB27V+QW6VFmGKQo4UIZhFS8GXsCllqPGVW/s5Kcr
	eGL78sYfAiP15Wp8vDUqXMeqxSXhbviEpHYxIZ0mLTRzKu2qMcPClh0NmYDNw++d7zdsYf
	iM+ocJUPnqEto7FCI2ezzKUs4w84OLwFArA/MnNrKhLV4JA4wL2C/bltr1oAMw==
Date: Wed, 22 May 2024 15:06:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-sunxi@lists.linux.dev,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, didi.debian@cknow.org, Marek Kraus
 <gamiee@pine64.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions for
 Pine64 boards
In-Reply-To: <20240522110507.51b12966@donnerap.manchester.arm.com>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
 <057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>
 <5635a6e79427e43ef20b690c766267d0@manjaro.org>
 <20240522110507.51b12966@donnerap.manchester.arm.com>
Message-ID: <90fada7d9a37a5e413b16bc176ec2f8d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-05-22 12:05, Andre Przywara wrote:
> On Wed, 22 May 2024 08:10:21 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-05-22 02:48, Icenowy Zheng wrote:
>> > 在 2024-04-23星期二的 03:00 +0200，Dragan Simic写道：
>> >> Correct the descriptions of a few Pine64 boards and devices,
>> >> according
>> >> to their official names used on the Pine64 wiki.  This ensures
>> >> consistency
>> >> between the officially used names and the names in the source code.
>> >>
>> >> Cc: Marek Kraus <gamiee@pine64.org>
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> ---
>> >>
>> >> Notes:
>> >>     This completes the correction of the descriptions of the Pine64
>> >> boards
>> >>     and devices, which was started with the Pine64 boards and devices
>> >> based
>> >>     on Rockchip SoCs. [1]
>> >>    
>> >>     [1]
>> >> https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/
>> >>
>> >>  Documentation/devicetree/bindings/arm/sunxi.yaml | 12 ++++++------
>> >>  1 file changed, 6 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> >> b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> >> index 09d835db6db5..b66873ae2d71 100644
>> >> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> >> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> >> @@ -709,17 +709,17 @@ properties:
>> >>            - const: sochip,s3
>> >>            - const: allwinner,sun8i-v3
>> >>  
>> >> -      - description: Pine64 PineH64 model A
>> >> +      - description: Pine64 H64 Model A
>> >>          items:
>> >>            - const: pine64,pine-h64
>> >>            - const: allwinner,sun50i-h6
>> >>  
>> >> -      - description: Pine64 PineH64 model B
>> >> +      - description: Pine64 H64 Model B
>> >
>> > Sorry for replying so late, but I don't think there is a Pine64 H64
>> > board. The Pine64 wiki calls it Pine H64. [1]
>> >
>> > [1] https://wiki.pine64.org/wiki/PINE_H64
>> 
>> Good point, thanks.  Though, this board is really an exception to
>> the naming scheme employed for the Pine64 boards, so perhaps it would
>> actually be better to rename the board in the Pine64 wiki, by adding
>> "64" to "Pine", to ensure consistency.
> 
> I am sorry, but I don't think this is how it works. The board is really
> called "Pine H64", that's printed on the board [1] and everywhere else 
> [2].
> That's a choice the manufacturer made, and renaming some Wiki page 
> won't
> change that. I understand the engineer's desire to make everything nice 
> and
> consistent ;-) , but I am afraid that's not our call. After all this 
> file
> is to document the device naming, not to be an example of consistent
> naming schemes.
> 
> [1] https://linux-sunxi.org/images/5/53/Pineh64_top.jpg
> [2] https://pine64.org/devices/pine_h64_model_a/

Those are all valid concerns.  Though, when it comes to the silkscreened
labels on PCBs, sometimes they have no connection with the real, 
official
board names.  An almost funny example :) is the QuartzPro64 board, also
from Pine64. [3]

I'll check with Pine64 are there some intentions for unifying the 
officially
used board names, and if there aren't, I'll submit the v2 of this series
with the corrected board names.

[3] 
https://wiki.pine64.org/images/f/fe/Quartzpro64_whole_board_top_resized.jpeg

>> Alas, the Pine64 wiki is currently in read-only mode, due to some
>> recent issues with the underlying hardware that runs it.  Migration to
>> another form of documentation for Pine64 boards is also a possibility,
>> which makes the updates even more complicated.
>> 
>> With all this in mind, I think it would be the best to rename the 
>> board
>> on the Pine64 side, to ensure consistency, and keep this patch as-is.
>> I'll make a mental note to do that on the Pine64 side once the current
>> situation with the Pine64 wiki is resolved.
>> 
>> >>          items:
>> >>            - const: pine64,pine-h64-model-b
>> >>            - const: allwinner,sun50i-h6
>> >>  
>> >> -      - description: Pine64 LTS
>> >> +      - description: Pine64 A64 LTS
>> >>          items:
>> >>            - const: pine64,pine64-lts
>> >>            - const: allwinner,sun50i-r18
>> >> @@ -748,17 +748,17 @@ properties:
>> >>            - const: pine64,pinephone
>> >>            - const: allwinner,sun50i-a64
>> >>  
>> >> -      - description: Pine64 PineTab, Development Sample
>> >> +      - description: Pine64 PineTab Developer Sample
>> >>          items:
>> >>            - const: pine64,pinetab
>> >>            - const: allwinner,sun50i-a64
>> >>  
>> >> -      - description: Pine64 PineTab, Early Adopter's batch (and
>> >> maybe later ones)
>> >> +      - description: Pine64 PineTab Early Adopter
>> >>          items:
>> >>            - const: pine64,pinetab-early-adopter
>> >>            - const: allwinner,sun50i-a64
>> >>  
>> >> -      - description: Pine64 SoPine Baseboard
>> >> +      - description: Pine64 SOPine
>> >>          items:
>> >>            - const: pine64,sopine-baseboard
>> >>            - const: pine64,sopine
>> >>
>> 

