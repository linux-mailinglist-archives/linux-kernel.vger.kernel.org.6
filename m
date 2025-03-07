Return-Path: <linux-kernel+bounces-551289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C496DA56AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3972189B57B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECE121C18A;
	Fri,  7 Mar 2025 14:40:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D721ABDC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358419; cv=none; b=EyxOgaEyiY2/JsYH6yWs+aXwqV9/HG2v5sbz0DYGrEqDULfE9JgZ0khh/0knLeIlBlPrv6j3kyJAkfBd9sOcTiPV1UURmqZ9Ns992JUm+UWIOhF+zduCg0keSzr2keazpOJLs7fEsq90dbQxyq+Sd5aPeBc6hp2G3kIVgamBJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358419; c=relaxed/simple;
	bh=zJqZeLk7niPxv+gNZzVEwSQrvYWMHIJnaH5lMK+VwS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3l1ekqZBMywdJoJKYtUgsr4ksIyW8xv0DC056nCt/qu6wBX8ujnLiQ3uQsAUOgbSb0YQkk4YuS0f3H5oRBrcLzNcJUc/bi4vaEdHonIHjaFo0WI144TJD5cM+GbyJ9xSRwp+R+HeAtu/oi08xqY13bQmhPJEi44JSnOX7ULJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tqYrk-0004Bx-MV; Fri, 07 Mar 2025 15:39:56 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tqYrk-004VBw-0X;
	Fri, 07 Mar 2025 15:39:56 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tqYrk-000XG3-06;
	Fri, 07 Mar 2025 15:39:56 +0100
Date: Fri, 7 Mar 2025 15:39:56 +0100
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
Message-ID: <20250307143956.aft3xolakts3nlja@pengutronix.de>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
 <20250226212219.lthoofw7nrs3gtg6@pengutronix.de>
 <20250227112856.aylsurbt3uqm4ivw@pengutronix.de>
 <541539db-0015-41de-837f-aabbea68486a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <541539db-0015-41de-837f-aabbea68486a@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-03-05, Laurentiu Mihalcea wrote:
> 
> On 2/27/2025 1:28 PM, Marco Felsch wrote:
> > Hi Laurentiu,
> >
> > On 25-02-26, Marco Felsch wrote:
> >> Hi,
> >>
> >> On 25-02-26, Laurentiu Mihalcea wrote:
> >>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>>
> >>> The AIPSTZ bridge offers some security-related configurations which can
> >>> be used to restrict master access to certain peripherals on the bridge.
> >>>
> >>> Normally, this could be done from a secure environment such as ATF before
> >>> Linux boots but the configuration of AIPSTZ5 is lost each time the power
> >>> domain is powered off and then powered on. Because of this, it has to be
> >>> configured each time the power domain is turned on and before any master
> >>> tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).
> >> My question still stands:
> >>
> >> Setting these bits requires very often that the core is running at EL3
> >> (e.g. secure-monitor) which is not the case for Linux. Can you please
> >> provide more information how Linux can set these bits?
> > Sorry I didn't noticed your response:
> >
> > https://lore.kernel.org/all/a62ab860-5e0e-4ebc-af1f-6fb7ac621e2b@gmail.com/
> >
> > If EL1 is allowed to set the security access configuration of the IP
> > cores doesn't this mean that a backdoor can be opened? E.g. your
> > secure-boot system configures one I2C IP core to be accessible only from
> > secure-world S-EL1 (OP-TEE) and after the power-domain was power-cycled
> > it's accessible from EL1 again. This doesn't seem right. Why should a
> > user be able to limit the access permissions to an IP core to only be
> > accessible from secure-world if the IP core is accessible from
> > normal-world after the power-domain was power-cycled.
> >
> > Regards,
> >   Marco
> 
> I'm no security expert so please feel free to correct me if I get
> something wrong.
> 
> This isn't about S/NS world. The bridge AC doesn't offer any
> configurations for denying access to peripherals based on S/NS world.

It does, please see the AIPSTZ_OPACR register definition. The imx-atf of
sets OPACR registers to 0 (of course), which means that the S/NS is not
checked _but_ it can be configured.

Also please see chapter 4.7.6.1 Security Block:

The AIPSTZ contains a security block that is connected to each
off-platform peripheral. This block filters accesses based on
write/read, non-secure, and supervisor signals.

> AFAIK that's the job of the CSU (central security unit), which is a
> different IP.

Please see above.

> Perhaps I shouldn't have used the term "trusted" as it might have
> ended up creating more confusion? If so, please do let me know so I
> can maybe add a comment about it in one of the commit messages. In
> this context, "master X is trusted for read/writes" means "master X is
> allowed to perform read/write transactions".

No you didn't confused me but you triggered my interest :) and I started
to check the (S)TRM.

> Even if the bridge is configured to allow read/write transactions from
> a master (i.e: master is marked as trusted for read/writes) that
> wouldn't be very helpful.

We're talking about the IP access permissions, right. If the
"secure-I2C" is accessible from NS world this would make a difference of
course.

> You'd still have to bypass the CSU configuration which as far as I
> understand is also used by the bridge to deny access to peripherals
> (e.g: if transaction is secure+privileged then forward to peripheral,
> otherwise abort it). See the "4.7.6.1 Security Block" and "4.7.4 
> Access Protections" chapters from the IMX8MP RM.

I have read this too, also that the AIPSTZ can force the mode into
user_mode regardless of the CSU settings, if I get this correct.

What I don't understand as of now is the interaction of the AIPSTZ and
the CSU. You can configure different bus-masters within the CSU to be
S/NS as well as the pheripherals. Now the part which I don't understand
right now: According the OPACx register description:

x0xx SP0 — This peripheral does not require supervisor privilege level
           for accesses.
x1xx SP1 — This peripheral requires supervisor privilege level for
           accesses. The master privilege level must indicate supervisor
	   via the hprot[1] access attribute, and the MPROTx[MPL] control
	   bit for the master must be set. If not, the access is
	   terminated with an error response and no peripheral access is
	   initiated on the IPS bus.

The peripheral can be configured via the AIPSTZ as well. So which IP
(CSU or AIPSTZ) override the other if the settings don't match, e.g. if
CSU says: "this I2C controller for secure-world" and the AIPSTZ says:
"this I2C is for non-secure-world".

> Given all of this, I think the purpose of this IP's AC is to add some
> extra, light, security features on top of the CSU.

Or to override the CSU settings like the MPROTOx values:

xxx0 MPL0 — Accesses from this master are forced to user-mode
           (ips_supervisor_access is forced to zero) regardless of the
	   hprot[1] access attribute.
xxx1 MPL1 — Accesses from this master are not forced to user-mode. The
            hprot[1] access attribute is used directly to determine
	    ips_supervisor_access.

Can you pleae elaborate a bit more how NXP designed the interaction
between both the AIPSTZ and the CSU?

Regards,
  Marco

