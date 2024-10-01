Return-Path: <linux-kernel+bounces-345377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1398B570
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A101F21EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781861BD03B;
	Tue,  1 Oct 2024 07:25:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FB1BD02E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767513; cv=none; b=ejZK8Lo6NmTMWz55jE0Fb4uu3fW9aV1BqIkIB8zkI2Acsj+B2Aq5lT+qaQxbwWr1BdMwI27AZM3YxwwKfjGm4RcICXLRggqni45dcNOge68OthZ5pWxrHOSdap/WpuqDbiHJNY8dSL2y6jNDRm6IAsRhF89XyVDT8tZ0tVBPfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767513; c=relaxed/simple;
	bh=jq7gk2jfZ+hdJ5OeRVSANOBdMJ5J12z2YwRxflKCCIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJNnqAcR/03zpRWutLkmYb4syswlaPwfvSZdDPMZAzxe5ByWaPXWmu2jrRTvGNpYXtczJ5oer+7AAFRBIzBtOBhkpKELpEupGuIGNVQAi3twEfZ0iocMznbxg4dMfadoNuOI0C3Ck0rAq+Dde5nyFmF2ZYlUvvc5+HHPFmPWWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXFe-0001fs-Ec; Tue, 01 Oct 2024 09:24:54 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXFd-002p0t-VX; Tue, 01 Oct 2024 09:24:53 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXFd-004tso-2r;
	Tue, 01 Oct 2024 09:24:53 +0200
Date: Tue, 1 Oct 2024 09:24:53 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

gentle ping as this is series is two months old now.

Regards,
  Marco

On 24-08-07, Marco Felsch wrote:
> Hi,
> 
> this patchset is based on Johan's patches [1] but dropped the need of
> the special 'serial' of-node [2].
> 
> With the patches in place and the usb hierarchy described in properly we
> can use serdev on-top of usb-serial. The below example adds the support
> for the following hierarchy:
>  - host->usb-hub->ftdi-usb-uart->bt/wlan-module:
> 
> &usb_dwc3_1 {
> 	dr_mode = "host";
> 	status = "okay";
> 
> 	hub@1 {
> 		compatible = "usb424,2514";
> 		reg = <1>;
> 
> 		vdd-supply = <&reg>;
> 		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		device@1 {
> 			compatible = "usb403,6010";
> 			reg = <1>;
> 
> 			#address-cells = <2>;
> 			#size-cells = <0>;
> 
> 			interface@0 {
> 				compatible = "usbif403,6010.config1.0";
> 				reg = <0 1>;
> 
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 
> 				bluetooth {
> 					compatible = "nxp,88w8987-bt";
> 					fw-init-baudrate = <3000000>;
> 				};
> 			};
> 		};
> 	};
> };
> 
> If no serdev node is found the usb-serial is exposed as usual and can be
> accessed via /dev/ttyUSBx.
> 
> Regards,
>   Marco
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-serial-of&id=b19239022c92567a6a9ed40e8522e84972b0997f
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Marco Felsch (3):
>       serdev: ttyport: make use of tty_kopen_exclusive
>       USB: serial: cosmetic cleanup <space><tab> mix
>       USB: serial: enable serdev support
> 
>  drivers/tty/serdev/serdev-ttyport.c |  9 ++++++---
>  drivers/usb/serial/bus.c            | 10 ++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240807-v6-10-topic-usb-serial-serdev-83a7f8f86432
> 
> Best regards,
> -- 
> Marco Felsch <m.felsch@pengutronix.de>
> 
> 

