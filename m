Return-Path: <linux-kernel+bounces-327341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B36977463
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6717F283305
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5931C172E;
	Thu, 12 Sep 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="X85expuw"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE517DFF5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180570; cv=none; b=iykKwvfxf8DnG2LJJ9w/GeJqZsz+cQDFNbjnfrgCi13sr+b6jp4lNHilkUVPCYgW0EGAuY/JicJWyqLRJeNTEt7ujkabnZwzG6ZA+GjBmh5tnAsHZXu+jWB/Elvfc+CMeki6LGAinQ9+TaNj5GMyrZaoCuPyiJ9d6ff86tbreCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180570; c=relaxed/simple;
	bh=HESB9tj7zMNiDW/ln+TD7ixuKlRE2u/tZMAMSZTRNMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0WkXFYCW8Ks0pG4YODbFBxjwmUGrBr2rfjAlMDu6TlylTCiKFealRMfg+YtW7uQ4N//PBOZCYLmulqBIFhIZI9HgKYFXHlKj53ALUFAGYqMsPLxsEYOBgN8eKY6wDkusc9ryBivCIjjqfDSy18ewyUnjoM04u2OV2AiZcyEEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=X85expuw; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726180531;
 bh=rns+bPTPYHjFxU/x4Zy7sEWc0Gr6ktnAqcJoJdO8VEg=;
 b=X85expuw4ZbdZykYAWLCoZxLKhdwvB7CYGRjVrLz6WUG0t1UBJELJfqGtX8SclAdVWj/1ln3S
 Wm4wvh4r+u0/UaTASkHgNWMzc0uJgFXTPDzGWJrO7BI+y3eoitdwFQELOnLlFYbupj8PnxDiKwA
 UytRVvISzj9WuWXknNKYtpy9YclWSAhGxDGSDZNSQZ+IKLHyXiaHnLENRZyMznW93UqlTAOBfS5
 +ONW9Q7xEWD+GSAY2dO7OnBn3Z6o6UH48kqBQxp2YiXQVk6KE29jgK66DPIaf5L451PJKI0ximo
 zI18lHZ2O1/2Mnmw+XAGNevxGyK5kPF+aBBaqFETrUeA==
Message-ID: <8c0b8145-3e90-42e6-8e1a-5be6424d1055@kwiboo.se>
Date: Fri, 13 Sep 2024 00:35:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
To: Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
 Chris Morgan <macromorgan@hotmail.com>, Alex Zhao <zzc@rock-chips.com>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jing Luo <jing@jing.rocks>, Kever Yang <kever.yang@rock-chips.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>,
 Joshua Riek <jjriek@verizon.net>
References: <20240912025034.180233-1-CFSworks@gmail.com>
 <20240912025034.180233-5-CFSworks@gmail.com>
 <ed4b6913-f19b-4280-b3b2-f5bb1e7f47eb@kwiboo.se>
 <CAH5Ym4jEMvBVQNNS6U49RWTAVPX4GmOVC-VjgXsFCR=X68QWgA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAH5Ym4jEMvBVQNNS6U49RWTAVPX4GmOVC-VjgXsFCR=X68QWgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66e36cb3fcb6c7d83e7bbd3c

On 2024-09-12 23:06, Sam Edwards wrote:
> On Thu, Sep 12, 2024 at 12:53 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Sam,
>>
>> Sounds like this may be missing
>>
>>         rockchip,dp-lane-mux = <0 1 2 3>;
>>
>> or
>>
>>         rockchip,dp-lane-mux = <3 2 1 0>;

Small correction, the second 4-lane mode would be described as:

	rockchip,dp-lane-mux = <2 3 0 1>;

>>
>> if all lanes are used for DP and none are used for USB.
>>
>> It should help describe the hw and also help the driver set mode to
>> UDPHY_MODE_DP and that should disable the u3 port, or there may be an
>> issue to fix in the phy driver.
> 
> Thanks for your insights Jonas!
> 
> I haven't yet gotten to DP enablement so I don't know the correct DP
> layout. Ultimately I do want the USBDP0 node to have the necessary
> properties for DP, but alas that's a patch for another day.
> 
> Nonetheless, I briefly tried it and I don't think UDPHY_MODE_DP
> affects the PHY's "backend" (ctrl<->phy iface) at all, only the
> availability of frontend lanes to the USB-specific backend: So port u3
> is still enabled, there's just no way to reach it electrically.
> 
> With that in mind, would you recommend that I add a placeholder
> dp-lane-mux of 0 1 2 3 for now, just to keep the PHY from attempting
> to speak USB to a DP device? I don't foresee any harm in leaving it
> as-is but you may know something that I don't.

The rk_udphy_u3_port_disable() call in usbdp phy driver should help set
the usb3otg0_host_num_u3_port=0 you mentioned:

  .usb3otg0_cfg = RK_UDPHY_GEN_GRF_REG(0x001c, 15, 0, 0x1100, 0x0188),
  .usb3otg1_cfg = RK_UDPHY_GEN_GRF_REG(0x0034, 15, 0, 0x1100, 0x0188),

Here the disable/enable values is little bit inverted in macro, i.e.
enable=0x0188 is the value set when u3_port_disable(disable=true) is
called.

Guessing that because the phy is not referenced its init() ops never
gets called and u3 never gets disabled unless a usb3-phy is referenced.

> 
>>
>>> +     status = "okay";
>>> +};
>>> +
>>> +&usb_host0_xhci {
>>> +     extcon = <&u2phy0>;
>>> +     maximum-speed = "high-speed";
>>
>> If this only use the USB2 phy, this should probably also override the
>> default phys and phy-names props with:
>>
>>         phys = <&u2phy0_otg>;
>>         phy-names = "usb2-phy";
> 
> I agree completely: if the controller doesn't need the USB3 PHY, then
> it should not (implicitly) be specified in the DT. Being able to add
> these overrides is a big goal of mine as well. :)
> 
> Sadly, `phys` is what initializes USBDP's USB-side backend, so without
> it the RX_STATUS line goes floating, and because the controller still
> expects a port there, it misbehaves:
> [   30.981076] usb usb2-port1: connect-debounce failed
> 
> I can tell the controller that there is no u3 port by doing this in U-Boot:
> => mw.l 0xfd5ac01c 0xf0000000 # usb3otg0_host_num_u3_port=0
> => boot
> ...and that makes single-PHY operation work perfectly! But unless
> Linux itself effects that change, this patch can't rely on that GRF
> being set correctly.
> 
> Do you have a recommendation on how I might go about disabling this
> port? I sent a patchset last year [1] that had the DWC3/xHCI driver
> ignore enumerated u3 ports when the maximum-speed was set to
> high-speed, but the consensus seems to be that this shouldn't be
> addressed at the xHCI driver level, so somehow zeroing the necessary
> GRF bits sounds like the way to go here. What do you think?

Not sure if it would help but could be that part of init() ops should be
moved to probe(). Would still require the phy driver to probe before usb
controller for that to help/work.

Adding a rockchip,dp-lane-mux prop and keeping the phys prop as-is is
probably easiest way for now.

One option for future could possible be to have grf driver disable u3
and modify usbdp phy driver to enable u3 instead of disable u3, not
sure this will fully work, init of the usbdp phy seem very sensitive
and possible a one-time op. Trying to "usb start" in U-Boot will only
work one time, using "usb reset" or a "usb stop/start" cycle will cause
usbdp phy init to fail and a full board reset is needed to get port
working again.

Regards,
Jonas

> 
> Kind regards,
> Sam
> 
> [1]: https://lore.kernel.org/all/20231208210458.912776-1-CFSworks@gmail.com/


