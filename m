Return-Path: <linux-kernel+bounces-207422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1629016F0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B01C20CC4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52347779;
	Sun,  9 Jun 2024 16:06:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71E14265;
	Sun,  9 Jun 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717949176; cv=none; b=I+GFQqoLhbjqb6HXUPinnt1lB5iGuyJyhJPc/+Pb/4i4k3M65pEtIdIAHxMbk4rk4cnTAJs3KcWkpd7OTVs3beA1DlmjszRQGMatDLmVrTFIWcrKvJC0q7dAa+9EE3gra3qi/CUANkqCfutYe0tAV6zE7I8xqMOI/kHP3oX/zI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717949176; c=relaxed/simple;
	bh=53/N3nydP1Frzk260uGA223xS+Df7guFfr89dKFOU10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urslX9vjfQKOsaIYeuxUzZFDPE3Bf1JoNY9tEfau7AghAIG1vdZLeiAKzORwKgELCgkYRpQTuDS+ASjqSoNwHT51/x2ofzU0WLK9ueH/OfejFq9m+a9vJNHgor12i3J7CHHjHl96rFI4KK0PmwVvn8BMEgMA1pK/Ap+G+RQLsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sGL3G-0004V8-Ee; Sun, 09 Jun 2024 18:05:50 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Space Meyer <me@the-space.agency>, Sebastian Kropatsch <seb-dev@mail.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board
Date: Sun, 09 Jun 2024 18:05:49 +0200
Message-ID: <4035271.e99z0qppnp@diego>
In-Reply-To: <f5cfcf3e-27e5-464a-9adf-261753ad6de7@mail.de>
References:
 <20240602211901.237769-1-seb-dev@mail.de> <11747652.CDJkKcVGEf@phil>
 <f5cfcf3e-27e5-464a-9adf-261753ad6de7@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 8. Juni 2024, 19:22:01 CEST schrieb Sebastian Kropatsch:
> Hello,
> 
> Am 08.06.2024 um 16:38 schrieb Heiko Stuebner:
> > Am Donnerstag, 6. Juni 2024, 15:13:20 CEST schrieb Space Meyer:
> >> On 02.06.2024 22:20, Sebastian Kropatsch wrote:
> >>> Some RK3588 boards are still using this property, the following quote
> >>> is from rk3588-tiger-haikou.dts for example:
> >>>       &sdmmc {
> >>>           /* while the same pin, sdmmc_det does not detect card changes */
> >>>           cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> >>>
> >>> I am unsure as to whether this comment from the quote might apply for
> >>> the CM3588 as well. Please let me know if you are able to tell :-)
> >>
> >> I don't quite understand this. However GPIO0_A4 *is* routed to the micro
> >> sd CD according to the NAS schematic, page 16 around A5.
> > 
> > for the actual sdmmc_det functionality ... possibly some pinconfig thing?
> > I.e. pull-whatever settings?
> 
> I have no idea. I just removed the "cd-gpios" line in v2 due to a
> suggestion by Jonas Karlman and then stumbled over this comment.
> So I'm not sure whether to include or not include this property
> for the CM3588 NAS since I don't know the consequences.
> Probably in the end it doesn't even matter :)
> 
> >>> +	vcc_3v3_pcie30: regulator-vcc-3v3-pcie30 {
> >>> +		compatible = "regulator-fixed";
> >>> +		regulator-name = "vcc_3v3_pcie30";
> >>> +		regulator-always-on;
> >>> +		regulator-boot-on;
> >>> +		regulator-min-microvolt = <3300000>;
> >>> +		regulator-max-microvolt = <3300000>;
> >>> +		vin-supply = <&vcc_5v0_sys>;
> >>> +	};
> >>
> >> These are 4 seperate regulators according to the schematic. However, as
> >> they are all fixed, idk if they should be split or kept like this.
> > 
> > personally, I really like the power-diagram to match schematics.
> > I.e. $debugfs/regulator/regulator_summary will produce a really nice
> > graph of all the system's regulators, so it's definitly nice if the
> > hirarchy matches. Also prevents head-scratching later on ;-)
> 
> These are indeed 4 different regulators according to the schematic.[1]
> But they don't have any pin to control them separately. I can
> duplicate them 4 times if that's the preferred practice.
> 
> But matching the schematics won't be possible either way, since
> e.g. there is only one single 5v regulator acc. to the schematic
> (vcc_5v0_sys), but vcc_5v0_host_20, vcc_5v0_host_30, vbus_5v0_typec
> and so on are needed since each device has a different control pin
> to enable its power. Or is there a better way to solve this while
> having only one 5v regulator node but still being able to set the
> control pins separately for the different USB ports?

The other option we often use is to define multiple phandles
for a regulator. For exactly that case where one gpio controls
a set of regulators.

So you have one regulator

vcc_5v0_host_20: vcc_5v0_host_30: vbus_5v0_typec: regulator-vcc-whatever {
	foo;
}

So in short there is not set rule, but more like a best-effort to get as
close to the schematics as possible. I.e. someone going from dt
to schematics should be able to just search for an identifier
(of course same for the other direction).


Heiko



