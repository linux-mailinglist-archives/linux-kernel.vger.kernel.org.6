Return-Path: <linux-kernel+bounces-519616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC45A39F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4A73B0C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491326A0C2;
	Tue, 18 Feb 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EysST+l/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09726AA8C;
	Tue, 18 Feb 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888777; cv=none; b=oRH3N449hyB/7wJFQi9DpJIuQ0p94n1YbTRQWFbhqubStsa7qeyxTMWZXSOaC7PwUcs5r4an/Ec7/I+zXxh7442uZfHgWbU9X9ui898WQ06P19SMmhDzdCjsk16/dlovRCvgRhcI+4FcO3wN8Mynf+EXeM3NziG6/Zbuk06r/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888777; c=relaxed/simple;
	bh=M0zrnO6XdP/Qfg9zKCzcxP5dotl5AGGLdqW4VqTdR7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6v5yRlBi1KfFKCyN/wEKuFfpl1KHB4Ky1Buk83ivaTAUx80OVJlXtzDmveRP/zTG1nTSkrSNKGRHwqbBYgxp50JH9LOQkcsGbh1rztqKTluVHxytcaF8f0BVGudbFOm8EXhUe9YGK7WdRNYXrmhzqRIjcSRlEB256hGGPpiNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EysST+l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA20CC4CEE6;
	Tue, 18 Feb 2025 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739888776;
	bh=M0zrnO6XdP/Qfg9zKCzcxP5dotl5AGGLdqW4VqTdR7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EysST+l/cDYwZHdRaQ/R8wjdS95MtgFE8WQB13dRreYpTkWJBRkSzYe84v41ihPbB
	 9nHCwVh+qoxSnUK+zWvTIdnClmgkKVP2Y1mDXa4CAjdtgRWK1S4kdzdH2mrEYGtGHF
	 cuSYRLltQQQ0x/FtJrBC/6GyvE70XNyIK4cmFz7CoK30mZFm+voF8Yxe5lG7DFSJFm
	 a0aTz0tn3+FcR7awwurchR2kZ6a4gmeGIqY43CWawaY2cqEH1niEK7nXnz1LW50eDr
	 Bwm+GvOdvLGynO2CWt7k8wgDCNFVeIVkJRVDapm3K8aM+zuBPpuyFIiTgbNTb7aZBg
	 yFIUvV550LLOg==
Date: Tue, 18 Feb 2025 22:26:11 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev, Jameson Thies <jthies@google.com>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add support for setting
 USB mode via sysfs
Message-ID: <Z7SYg8HaSVx9QyH9@tzungbi-laptop>
References: <20250210130419.4110130-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210130419.4110130-1-akuchynski@chromium.org>

On Mon, Feb 10, 2025 at 01:04:19PM +0000, Andrei Kuchynski wrote:
> +static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode mode)
> +{
> +	struct cros_typec_port *port = typec_get_drvdata(tc_port);
> +	struct ec_params_typec_control req = {
> +		.port = port->port_num,
> +		.command = (mode == USB_MODE_USB4) ?
> +			TYPEC_CONTROL_COMMAND_ENTER_MODE : TYPEC_CONTROL_COMMAND_EXIT_MODES,
> +		.mode_to_enter = CROS_EC_ALTMODE_USB4

The symbol `CROS_EC_ALTMODE_USB4` doesn't exist.  On a related note, wouldn't
it always enter CROS_EC_ALTMODE_USB4 if the value is hard-coded here?

> @@ -84,6 +102,13 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
>  		cap->prefer_role = ret;
>  	}
>  
> +	if (fwnode_property_present(fwnode, "usb2-port"))
> +		cap->usb_capability |= USB_CAPABILITY_USB2;
> +	if (fwnode_property_present(fwnode, "usb3-port"))
> +		cap->usb_capability |= USB_CAPABILITY_USB3;
> +	if (fwnode_property_present(fwnode, "usb4-port"))
> +		cap->usb_capability |= USB_CAPABILITY_USB4;

Are these defined somewhere?  E.g. the bindings?

