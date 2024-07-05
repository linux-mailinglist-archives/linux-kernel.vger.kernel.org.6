Return-Path: <linux-kernel+bounces-242208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D100C928506
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE431C20C09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0363146A62;
	Fri,  5 Jul 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhMuO46h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA54139E;
	Fri,  5 Jul 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171331; cv=none; b=g41Ur647AVG5AvvHoh896Pi/xjM9H8l1H0kLSD3Une0PjFCJ+8sXkb4qXhN1htpDOMDikgX+dvixL/xfi9/ZWD3G7fGfiIr5rOwr/+0PThqALhzXuQVlh83kSQrq+gCLudWH/k9TMbOMOye6pRAmcD39ukRUc+CHxD9vNoSRb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171331; c=relaxed/simple;
	bh=TdxFLpeeW3XQKl3frGnYYgNter4Yc8kHn7G/NIclOAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8N9tM0MWwtQy3XdqOU8VlR1yG4+K8KVfmj0SPWIItMEE3xWwsKIDVE7URbUqax0bFUqBcLS6X1BJ1w0g6HzGiBuh57wGkwnyc5LsW1Mz6n7rjpYOS1ZUj+lAAyBSJ6ngxqWVEUJWVPtflyq8CJ9tiNehVQG1+xr817odcn+iLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhMuO46h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED7DC116B1;
	Fri,  5 Jul 2024 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720171330;
	bh=TdxFLpeeW3XQKl3frGnYYgNter4Yc8kHn7G/NIclOAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhMuO46hjK1VINCj0SesbEJ8hJCVjwEeXYlNZbVA+Hf2F0wE+jBQ53PFIwW7LW1jY
	 m9m53vBTLR1E1G6kGaKHdMNknKvIfjY+8d5mhqb4L9rNr/Nw1DCXphBK2ft7h4DgRB
	 1E/LbCrkQw9PjdpoM3U8sCQ3rrKXAlWFAJ2vRnF6nFUGj4WGnCmKzDh8OkUyQe26qf
	 oW1XWARwHD1QCb+R0VR7Tb4Mv+3cg/pVAzr4C3FXgP6EVHGIsm7zNdraoHhJORi9ZI
	 xixJ8dlx4f2ZPVf00aPHiWxSIyOp+OrwQDf/ePUxoasYOEX6NA5pHTIOxVBXXEwVyC
	 yIbemC8tuU4cA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sPf8v-000000005og-1gP2;
	Fri, 05 Jul 2024 11:22:13 +0200
Date: Fri, 5 Jul 2024 11:22:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB: serial: option: add support for Foxconn T99W651
Message-ID: <Zoe7RT7o39C7iXmA@hovoldconsulting.com>
References: <20240705081709.105496-1-slark_xiao@163.com>
 <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
 <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>

On Fri, Jul 05, 2024 at 05:11:22PM +0800, Slark Xiao wrote:

> I have a concern about the test result of "usb-devices" in Ubuntu
> 22.04. Do you know why it wouldn't show our devices any more? 

No, sorry, no idea. Everything seems to work here with the latest
usbutils-017.

Is it just your devices that no longer show up or doesn't it work at
all?

Perhaps a change like this one could be involved:

	https://github.com/gregkh/usbutils/commit/3b79e9c866a17f0a5178b3b0bee63fab59a0003a	

I suggest you try an older version first and then either file a bug on
github or to Ubuntu.

Johan

