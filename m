Return-Path: <linux-kernel+bounces-441024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A89EC83B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9932813BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E424039F;
	Wed, 11 Dec 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMdixJof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18278241F22;
	Wed, 11 Dec 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907826; cv=none; b=hzb+/n1wJwIa929Wi+Eln1I2AmsKBa0S/PCHENkdnMDJ4bs9BwJjFoozzffjmFwzbzTxLpHNvK9mbXpqmGJ7mOihsZuZuDwdJ4mERq7mgwnVwuihL6018BkDSztH3WsD6RU4s2Y8/GgGaXeeCCWJ+iSGmPXxrHVzWiwVrncdXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907826; c=relaxed/simple;
	bh=lXBD1dsXFprpBU1bIFR3OglDWy1glL2zGK7MKIUGIEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN22ywgRwg6c4UAm1VbGDy3LNwa5CiDlyHbsK6IunYgYXQYjS2265plZtNswm6yMV6IkEHdrxmqMycv12/LRagBEFSj6+CgjWDTqxLCc8PbtUcuMLqfc2BglzDSUOTlf52xswPy2XhZdG0yyZP+Xi7boo1wARPxkQhtR0nWPBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMdixJof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9B4C4CED2;
	Wed, 11 Dec 2024 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733907825;
	bh=lXBD1dsXFprpBU1bIFR3OglDWy1glL2zGK7MKIUGIEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMdixJofo7zT5PDqG/AdvWrl2D2ckls8kcP9v05ZM0Ml2xefy9s3xmxLr2lRyOGpD
	 toc/ks3k7HTuU1AMygrQExldwc5YyQOCYDOAobkhTvc7gv0XfF0HYgeId31WYM+6MV
	 Pf5EAyqUEM50D1UqQcl3qI0wcwwv21YrKOk4NhUdgPi2CMESdZFVUAAUqdj1K0xtTa
	 QP+ZEzlZRyWjkM82ucpeew4TmyDGe57lh66RbhqnUmPoO31s4nfDZXMT0wgTrv+WMU
	 k1MFscUZL5mkG6cQkz3Jfr+CZJYeVVrG/2CMlt1Gd3sdC2uoj+Op9dqFG3RgWubGOP
	 1iKVTbswGgPeQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tLIdI-000000001c4-1npR;
	Wed, 11 Dec 2024 10:03:48 +0100
Date: Wed, 11 Dec 2024 10:03:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Swanemar <d.swanemar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add TCL IK512 MBIM & ECM
Message-ID: <Z1lVdHVmVST9XeIo@hovoldconsulting.com>
References: <20241104134217.3838-1-d.swanemar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104134217.3838-1-d.swanemar@gmail.com>

On Mon, Nov 04, 2024 at 02:42:17PM +0100, Daniel Swanemar wrote:
> Add the following TCL IK512 compositions:
> 
> 0x0530: Modem + Diag + AT + MBIM

> 0x0640: ECM + Modem + Diag + AT

> Signed-off-by: Daniel Swanemar <d.swanemar@gmail.com>

Thanks for the patch, looks good.

Next time remember to use the common commit summary prefix (e.g. as
shown by "git log --oneline" for the driver you are changing). I updated
the summary to:

	USB: serial: option: add TCL IK512 MBIM & ECM

when applying.

Johan

