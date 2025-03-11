Return-Path: <linux-kernel+bounces-555991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CDA5BF46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E91169773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CECC2505AF;
	Tue, 11 Mar 2025 11:38:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0045254843
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693095; cv=none; b=gr+DS8rcfJq94hF3CiqPQFz/qZdm6fNOXz+SX0L5sb/LuZYWEAil9INu21rDMoWu0+7/s4+1k4Y4gJ893Fg2GqPavvRVpu3T46SfV0Oz7vsts6lzSMQ5yhwW6sfKW0XqtDQZhK8nssYOo5qdTW+CfOmCRpj0+FnQJn9gSWMyRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693095; c=relaxed/simple;
	bh=vP/kGEBZIU6KLrstKzG0ch0zA0Ln/GSF9oD1jnqbtYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpYeMRWzxslaoh4yzBw5bH+0Ri4Uv2X+kptRTWajPnbd0A5dCUwvYkHUdlW3Mm5l0sob7GfNeY4CfAbZ/V+Fw7IEZQa/mMS/SuGUX5nl7qzMeJ49NHpOXAyJscPrz3TaMFOu0XZvA3jttZ0x0joM3Htv6fUoZ9Kb7ULBzZdtK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1trxva-0004bI-OE; Tue, 11 Mar 2025 12:37:42 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1trxva-005Ajv-12;
	Tue, 11 Mar 2025 12:37:42 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1trxva-007iuK-0e;
	Tue, 11 Mar 2025 12:37:42 +0100
Date: Tue, 11 Mar 2025 12:37:42 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] imx8mp: add support for the IMX AIPSTZ bridge
Message-ID: <20250311113742.uwedagolaxjy6unb@pengutronix.de>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
 <20250226212219.lthoofw7nrs3gtg6@pengutronix.de>
 <20250227112856.aylsurbt3uqm4ivw@pengutronix.de>
 <541539db-0015-41de-837f-aabbea68486a@gmail.com>
 <20250307143956.aft3xolakts3nlja@pengutronix.de>
 <4aef911d-d766-4ae7-951b-76843cf33c56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aef911d-d766-4ae7-951b-76843cf33c56@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-03-10, Laurentiu Mihalcea wrote:
> 
> 
> On 3/7/2025 4:39 PM, Marco Felsch wrote:
> > On 25-03-05, Laurentiu Mihalcea wrote:
> >> On 2/27/2025 1:28 PM, Marco Felsch wrote:
> >>> Hi Laurentiu,
> >>>
> >>> On 25-02-26, Marco Felsch wrote:
> >>>> Hi,
> >>>>
> >>>> On 25-02-26, Laurentiu Mihalcea wrote:
> >>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>>>>
> >>>>> The AIPSTZ bridge offers some security-related configurations which can
> >>>>> be used to restrict master access to certain peripherals on the bridge.
> >>>>>
> >>>>> Normally, this could be done from a secure environment such as ATF before
> >>>>> Linux boots but the configuration of AIPSTZ5 is lost each time the power
> >>>>> domain is powered off and then powered on. Because of this, it has to be
> >>>>> configured each time the power domain is turned on and before any master
> >>>>> tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).
> >>>> My question still stands:
> >>>>
> >>>> Setting these bits requires very often that the core is running at EL3
> >>>> (e.g. secure-monitor) which is not the case for Linux. Can you please
> >>>> provide more information how Linux can set these bits?
> >>> Sorry I didn't noticed your response:
> >>>
> >>> https://lore.kernel.org/all/a62ab860-5e0e-4ebc-af1f-6fb7ac621e2b@gmail.com/
> >>>
> >>> If EL1 is allowed to set the security access configuration of the IP
> >>> cores doesn't this mean that a backdoor can be opened? E.g. your
> >>> secure-boot system configures one I2C IP core to be accessible only from
> >>> secure-world S-EL1 (OP-TEE) and after the power-domain was power-cycled
> >>> it's accessible from EL1 again. This doesn't seem right. Why should a
> >>> user be able to limit the access permissions to an IP core to only be
> >>> accessible from secure-world if the IP core is accessible from
> >>> normal-world after the power-domain was power-cycled.
> >>>
> >>> Regards,
> >>>   Marco
> >> I'm no security expert so please feel free to correct me if I get
> >> something wrong.
> >>
> >> This isn't about S/NS world. The bridge AC doesn't offer any
> >> configurations for denying access to peripherals based on S/NS world.
> > It does, please see the AIPSTZ_OPACR register definition. The imx-atf of
> > sets OPACR registers to 0 (of course), which means that the S/NS is not
> > checked _but_ it can be configured.
> 
> which bits are you referring to more precisely? because, from the OPACR
> register definition we have:
> 
> 1) TP (Trusted protect) - bit 0 => controls whether the peripheral allows
> transactions from an untrusted master. A master is considered trusted if
> MTR/MTW (from MPR registers) is set to 1 (MTR means trusted for read,
> MTW means trusted for write)
> 
> 2) WP (Write protect) - bit 1 => controls whether the peripherals allows
> write transactions (i.e: is write protected or not)
> 
> 3) SP (Supervisor protect) - bit 2 => controls whether the master needs
> supervisor privilege or not to issue transactions to the peripheral. For
> Cortex-A53 this refers to the execution level (EL0 - EL3). There's no S/NS
> checks here. EL1-EL3 are supervisor accesses, EL0 is not.

Argh.. my head mixed the supervisor phrase :/

> 4) BW (Buffer Writes) - bit 3 => some flow control configuration bit I'd assume
> 
> 
> >
> > Also please see chapter 4.7.6.1 Security Block:
> >
> > The AIPSTZ contains a security block that is connected to each
> > off-platform peripheral. This block filters accesses based on
> > write/read, non-secure, and supervisor signals.
> 
> yep, but this block is not configured by the AIPSTZ. AFAIK it's configured
> by the CSU. So, as far as I understand it, the interaction is as follows:
> 
> basically you have the CSU which offers some security-related configurations
> (see "Table 4-16 Security Levels" from the section you've mentioned). These
> configurations are used by the AIPS bridges to filter transactions.
> 
> For example: assume you have peripheral X on AIPS5. The user configures
> the CSU such that peripheral X should only accept R/W transactions from
> privileged S world. Now, assume Cortex-A53 issues a transaction from
> NS EL1 (Linux, for example). The bridge will receive the transaction and
> check to see if it's privileged and S world. Since it's not then the transaction
> will be aborted.
> 
> The AIPS bridge offers no S/NS world-related configuration options. All you can
> do with it is:
> 
> 1) Mark certain masters as "trusted" and block read/writes based on that (via MPR's
> MTR/MTW and OPACR's TP)
> 2) Force transactions to user privilege (via MPR's MPL)
> 3) Make certain peripherals deny unprivileged transactions (via OPACR's SP)

Okay, thanks for the explanation with your input and the the TRM 4.7.6.1
saying:

8<--------------------------------------------------------------
A 3-bit input, 8-bit output translation block can be used such that only
three register bits are required to set the security profile and the
translation block will drive the correct 8-bit configuration vector.
Each peripheral connected to the AIPSTZ would require this translation
block. The top level AIPSTZ has this three bit input line
`csu_sec_level[2:0]' corresponding to each peripheral X.
8<--------------------------------------------------------------

I think that I understood the AIPSTZ user/supervisor now. The master
user/supervisor privileges are provided by the CSU HPx settings and can
be forced to user-mode via the AIPSTZ MPRTOx MPL0 bit.

The remaining bits from the config vector between the CSU and the AIPSTZ
are not taken into account.

Thanks for the clarification!

Regards,
  Marco

