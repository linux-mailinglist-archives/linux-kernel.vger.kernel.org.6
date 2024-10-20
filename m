Return-Path: <linux-kernel+bounces-373135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E2E9A52DC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3035B226FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8399F14A85;
	Sun, 20 Oct 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zO+4W+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27BEACE;
	Sun, 20 Oct 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729405040; cv=none; b=cl0UmLeA3la39rtdpPRDfKR3iF74QbGOyfTrYWmtND0TLOOTVD4RO1Ie4+BwJD1vI+xJajdHWeri73Pp3o+6J3aGMv+Jc0tkFXcKITiLaQHp8Iuiyy+2xpwMJtN5d8dAf/IYeOOoNyBLvq9/fIpwfV//BTDJTu0IuIm6eNk+FbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729405040; c=relaxed/simple;
	bh=ldOoNhi4IdrJjyWljDeozR5mBLUjHei28hhfCdhcuho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlM4AWMCdW60F1WVNDqJ9IvSQ/87wX+wg2kpQkCuQoi6+XiFOBj2wetCuehZrlQZN3+k7quMAV/di1/Gt3HsW+Hjc3cW36/gpn0Z+LNnfYrX5a+PS/qqu1gnqTxzhjYtZuwNK14cHQ+ysEscQTqyqgRNorYOVoplBtWg/n9J5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zO+4W+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CCEC4CEC6;
	Sun, 20 Oct 2024 06:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729405040;
	bh=ldOoNhi4IdrJjyWljDeozR5mBLUjHei28hhfCdhcuho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1zO+4W+q3PIe3Mw6cPffkqasQtvHWmCxyQ4v6sjdZUYmqmuLeTzO8auHOyLXT6dhU
	 /9a0Zf27OHdyJ3SkwlMQtRt8QigZhFciZ3YfM3K5Nhy6wmN07MOIrVL35g9y5tH/EE
	 tILDalDE9a8WgG5BFxYNuv6igUyJuT18twGowcHg=
Date: Sun, 20 Oct 2024 08:17:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dingyan Li <18500469033@163.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: storage: use US_BULK_FLAG_OUT instead of
 constant values
Message-ID: <2024102056-yearly-caregiver-d684@gregkh>
References: <20241019160822.6862-1-18500469033@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019160822.6862-1-18500469033@163.com>

On Sun, Oct 20, 2024 at 12:08:22AM +0800, Dingyan Li wrote:
> Macros with good names offer better readability. Besides, fix an error
> in the comments. In the flags, direction is in bit 7 instead of bit 0.

That means this should be at least 2 different patches please.
Remember, each change only does one logical thing.

thanks,

greg k-h

