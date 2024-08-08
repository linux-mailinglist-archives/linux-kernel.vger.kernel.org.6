Return-Path: <linux-kernel+bounces-279496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0794BDFC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFE31F21917
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C16918C93B;
	Thu,  8 Aug 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FoX53nRn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4B149DFA;
	Thu,  8 Aug 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121655; cv=none; b=XPWKcogpVLEznQuuxLCZEQF1X9zsfeZxebGEjfgRFmffOozWjDVbXt8nGZaYuSEmEKVIBtuUJz2BEfP5yUpcq0wRYQsHUoorY6Y2RbbuLrDM43H0M4QRE1UvZYrzCYxsEwBqutlVWW5Q479HoEj8QAxqYnVrHTZtNEbkL3LqC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121655; c=relaxed/simple;
	bh=CEyhPGSkXrl72ZDwTH2u/j1kNow6Xs5EFtfn4KS/qHs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z1CVeQG0+ecZiPgri5s6c1/v1HuJNO8wPPzg3/9JuZO8qGOSBS2KUc1NcSiMslqNsXK0xYmgUtUNC3aTxWnd9EmEgjj2L06C3JsQfBcA/U1v06LI+ymDHTgQ6qfmUSIXN2vBeLsp2B6rhj8+oPIr+CYTaQ4ysUAbnjww8Xbu7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FoX53nRn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-156-87-48.elisa-laajakaista.fi [91.156.87.48])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17761124E;
	Thu,  8 Aug 2024 14:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723121598;
	bh=CEyhPGSkXrl72ZDwTH2u/j1kNow6Xs5EFtfn4KS/qHs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FoX53nRnOS71ENjY0hXdwC1hxQ3n2cru453tGxW1xwdDMxtjnKrjrHoRQVtvYlECM
	 r7KUmItIBAUbiS2w2m44AQQn4GisPNGBpDb/ZGty3DGX6dRjDkDz67rGeLqD7INCDv
	 Lpq7HGSHR7q81lwOq0vj+nFCroBI9d/lzFe05DLA=
Message-ID: <d32d9229-9b40-4ebd-adf3-9ae9ef75b58b@ideasonboard.com>
Date: Thu, 8 Aug 2024 15:54:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
References: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
 <20240319-xilinx-dp-audio-v2-2-92d6d3a7ca7e@ideasonboard.com>
 <20240320153725.GA1771730-robh@kernel.org>
 <4073c6b5-629e-4e9c-86c2-a4b476fe775e@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <4073c6b5-629e-4e9c-86c2-a4b476fe775e@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rob,

On 21/03/2024 07:52, Tomi Valkeinen wrote:
> On 20/03/2024 17:37, Rob Herring wrote:
>> On Tue, Mar 19, 2024 at 10:22:37AM +0200, Tomi Valkeinen wrote:
>>> The DP subsystem for ZynqMP support audio via two channels, and the DP
>>> DMA has dma-engines for those channels. For some reason the DT binding
>>> has not specified those channels, even if the picture included in
>>> xlnx,zynqmp-dpsub.yaml shows "2 x aud" DMAs.
>>
>> New required entries is an ABI change. This message kind of indicates it
>> was a mistake, but should be a lot more explicit. Are things broken
>> without the entries? Need 'Fixes'?
> 
> I'll improve the desc for the next version.
> 
> So, yes, it's an ABI change, and as far as I can guess (I can't figure 
> out any other reason), the audio DMAs were left out by mistake or 
> misunderstanding. The Linux driver has not supported audio, so this has 
> not been an issue and nothing is broken.
> 
> Now that this series adds the audio support, I had to add the audio 
> DMAs. I considered making the DMAs optional in the DT, but that doesn't 
> sound right, even if that would keep the ABI compatibility (wouldn't 
> it?). The driver I add in this series does consider the audio DMAs as 
> optional, though. If they're not present, the driver will continue 
> without audio support.
> 
> So, strictly speaking I think this is a fix to the original commit that 
> adds the DT node, but as the driver using the audio DMAs comes in only 
> now, I think there's no need for the 'Fixes' and backporting.
> 
> I'm happy to change the approach if you think some other way is better.

Do you have any feedback on the above? Should I mark the audio DMAs as 
optional in the binding?

  Tomi

>   Tomi
> 
>>>
>>> Add the two audio DMAs to the binding.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>>   .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 10 
>>> ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/xlnx/ 
>>> xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/ 
>>> xlnx/xlnx,zynqmp-dpsub.yaml
>>> index 554f9d5809d4..6b754d4f260e 100644
>>> --- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp- 
>>> dpsub.yaml
>>> +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp- 
>>> dpsub.yaml
>>> @@ -100,12 +100,16 @@ properties:
>>>         - description: Video layer, plane 1 (U/V or U)
>>>         - description: Video layer, plane 2 (V)
>>>         - description: Graphics layer
>>> +      - description: Audio channel 0
>>> +      - description: Audio channel 1
>>>     dma-names:
>>>       items:
>>>         - const: vid0
>>>         - const: vid1
>>>         - const: vid2
>>>         - const: gfx0
>>> +      - const: aud0
>>> +      - const: aud1
>>>     phys:
>>>       description: PHYs for the DP data lanes
>>> @@ -194,11 +198,13 @@ examples:
>>>           power-domains = <&pd_dp>;
>>>           resets = <&reset ZYNQMP_RESET_DP>;
>>> -        dma-names = "vid0", "vid1", "vid2", "gfx0";
>>> +        dma-names = "vid0", "vid1", "vid2", "gfx0", "aud0", "aud1";
>>>           dmas = <&xlnx_dpdma 0>,
>>>                  <&xlnx_dpdma 1>,
>>>                  <&xlnx_dpdma 2>,
>>> -               <&xlnx_dpdma 3>;
>>> +               <&xlnx_dpdma 3>,
>>> +               <&xlnx_dpdma 4>,
>>> +               <&xlnx_dpdma 5>;
>>>           phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
>>>                  <&psgtr 0 PHY_TYPE_DP 1 3>;
>>>
>>> -- 
>>> 2.34.1
>>>
> 


