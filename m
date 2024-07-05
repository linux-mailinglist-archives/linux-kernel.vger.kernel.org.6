Return-Path: <linux-kernel+bounces-242439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F2192880A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6363CB21DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E726A149E0A;
	Fri,  5 Jul 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgoYJv1K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7AA1482F3;
	Fri,  5 Jul 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179339; cv=none; b=ZQYrHnV5TELPlTZSAohOj4eTLr+6fXyZdyZSkIqUyDiQse4iwAIauOnEWoAEyGVTBUl8et4bHfKRj24kuWfRjhv6kUIrFVb2rd4e90whzxKqINs1S2H0nwGk/frSE2ErEpCPJnJ/8Eo//QTqWzJpg2JK60BM48qi4EPEL04Gpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179339; c=relaxed/simple;
	bh=l7eHKj+T+etssusst1Hidt5TggjZOVOBAqE3clxrtlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlBXKeJ9S067UZS0dCmi5KXwzKCyIl6DWCwdhcJQMz2172jVsz38PfeDnHZrBSVYT4aQTUUi3j5/nNEV7t2loE2Nx049A+0gTFwVKZnwsjscS8Mr4/ytaHwLIqEfzVg1/ILQkMaWokZ/BUQUUuEWqLX0wjFbAf9GCMH3w3XBo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgoYJv1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC713C116B1;
	Fri,  5 Jul 2024 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720179338;
	bh=l7eHKj+T+etssusst1Hidt5TggjZOVOBAqE3clxrtlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgoYJv1KgMimYmEfZFP8nqE/ns2FPio4FoGL05l01NhsvDL8rpjPp949MpO6NvtXh
	 bIxTPnZut1fWvZUfT9/HAoH6WRYc3ZXFyGsCQxko+Qg9bDeFi3vLNNIYtnAGOb0d3V
	 MhshiK8VG+zVJaI+fm9oPf2+Gq5KNZzbswFlTw2gk1XNH0HIUOaRBJVgpL2wTgwDAA
	 zG+DrpM9ivdBlOp5MMUkjBb7rsXEEmKrtOnQUQkbq1ghydtXlcXq9wNO3XQVM0AJYX
	 fm99+SznguE1y8LNIT9CqJY9OmDSGs/Nyj2GQoLLyLQT6G8/OCkmkUE7cFzQT/skME
	 E0XAHh51wRNKQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sPhE5-000000000en-1tZC;
	Fri, 05 Jul 2024 13:35:41 +0200
Date: Fri, 5 Jul 2024 13:35:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] USB: serial: add missing MODULE_DESCRIPTION() macros
Message-ID: <ZofajSjhaaZsFRro@hovoldconsulting.com>
References: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>

On Tue, Jun 11, 2024 at 10:52:54AM -0700, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

I amended the commit message with the (recent) commit that added this
W=1 warning (and dropped C=1). I also tweaked three descriptions
slightly. End result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=9f4dc05107a6db3743e6b9ea4014cbdc3795682d

Thanks.

Johan

