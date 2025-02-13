Return-Path: <linux-kernel+bounces-512994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72CA34038
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBF1188BC77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E35227EAE;
	Thu, 13 Feb 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEfj/oJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7B23F417;
	Thu, 13 Feb 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453018; cv=none; b=DFbTVbm3gwyy2Cby0vnvmENWLh/r1NG3G69srUhjpm9wp8eSRhDOxCl2N+NILfB5fuuvNgKIVE9NZ2gjxwoLKe7xPO/l9W21qEZ0ydFMkag9cgp69NpDB7AMnBhKcX475jnFxYUCEW1vh2wG3xFz2psQf4z/gwAp3kP4uub74qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453018; c=relaxed/simple;
	bh=y1MNxzhI+yGa7bKcY6lEvd/Z72KfGmRAbyIUiL95ULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+ephd3nthwF3cclTLijNJ2MDBJvN/Rbf7lBgTQwn4xbRT48Yi7B3pa6wDd/+hDGaim/ofQTn9xdlctIXSu92qA0C7lNArCNcpz016zQMy8Pl1o+RAYmhbVGzStSvCrle9+HGx9Xa3nZfmtI8xWKjI343zL446uwtKZEf9SdK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEfj/oJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8339C4CEE2;
	Thu, 13 Feb 2025 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739453017;
	bh=y1MNxzhI+yGa7bKcY6lEvd/Z72KfGmRAbyIUiL95ULA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEfj/oJQFF6FoqBGjIgyP5tyZvcbC7xlcW1l3KJnLK9mGMLJWnwmQtd0a4HGRQYid
	 bRYf2e35eHmSjeVh7z+d7rfXnREokMNF70Xt4iK8TGtl22yQdR+or5Op6u5hvbm9Al
	 gRt7kXRh5xkmU0PiqKR/D7nbnZz3E7CaJ7Gu3UEs=
Date: Thu, 13 Feb 2025 14:23:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
Message-ID: <2025021314-obsolete-modify-2b96@gregkh>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
 <2025021302-malformed-captivity-e862@gregkh>
 <58af4b607adbe74725d4869f8f5a09cd5d3be2d3.camel@linaro.org>
 <2025021323-opponent-strategic-a27f@gregkh>
 <e5855e6d868b60277c24df01b2f27d8736301932.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5855e6d868b60277c24df01b2f27d8736301932.camel@linaro.org>

On Thu, Feb 13, 2025 at 01:10:49PM +0000, André Draszik wrote:
> Thanks Greg,
> 
> On Thu, 2025-02-13 at 12:56 +0100, Greg Kroah-Hartman wrote:
> > At a quick glance, tcpci_register_port() is called earlier in the
> > function, but when you error out here you did not call
> > tcpci_unregister_port().  What else needs to also be unwound?
> 
> This driver manages everything using devres, including calling of
> tcpci_unregister_port() via devres:
> 
>         ret = devm_add_action_or_reset(&client->dev,
> 				       max_tcpci_unregister_tcpci_port,
> 				       chip->tcpci);
> 
> is done just after tcpci_register_port(). As far as I can see nothing
> needs to be unwound explicitly.

Ugh, that wasn't obvious at all, sorry about that.  Yet another reason
to hate devm apis :)

thanks,

greg k-h

