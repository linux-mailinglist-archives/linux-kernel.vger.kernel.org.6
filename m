Return-Path: <linux-kernel+bounces-319116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367096F7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2D3B2175D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC051D27AD;
	Fri,  6 Sep 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWhNye39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7831CCB2C;
	Fri,  6 Sep 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635527; cv=none; b=bcP9l0MxqD//aEcc3ksAfYFGbVUFSlNTPKIV+gq/Cx19NeFGpbeARcypYr9lGHPXWnNpvMKt4cc6Sh6AQ/mHqCZX/v9vmyuoq9z7YOGAJTeBBJ0CatRxjHIx3WDxtL290ulE3TlXV/agujotvE5Qmb6vqWyWc7KQMVdEfS4zavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635527; c=relaxed/simple;
	bh=rciSxuZD53i8BTX8BoSl0WLC4ttW5yXIfU80/LugGk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwb/9bmf2t623HZatb7oATnCLKa7f2emFSRf+oAnon7g6SbL2CewSBHDoYVFG+eWSgAW1KvRZn40yaNxcrkODdT1qhgNcM6Xzalytb7lajeZmKMa8gS4dyoXMbjk6pjEdKxHOp0Yq6oE6tos2fF7//IKIccFnElpoDXK1tPkMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWhNye39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F91C4CEC4;
	Fri,  6 Sep 2024 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725635527;
	bh=rciSxuZD53i8BTX8BoSl0WLC4ttW5yXIfU80/LugGk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWhNye39IaX7G2AvQEkoOjcB4drNnrZTAVSU/D4CqvhZGELACYzyBlGsPCPsj36rP
	 5+OTf8VayUacWlr9nbGMd6griO7eLrpWSRY2U1GZvVMFTLqEOHkDYxhOG3rXvBLyg6
	 YIaLv0ecGRd4jPk3xToV3DcwpF4e+YC03vVy70Ilf+xAg/VhLSEaOt8lzqaf78NB+z
	 N0Xo+zRhdblnvSnP3TMS4X1i56q3M76++uZz+h1NHBQWLEbWBI33645XHOjVnX4BCI
	 1H00aY52ANNMGhCSTQn55FLQFcQ9j8cWzM8Dvpfu732JLEveAozuhJPm6UXGdIesnM
	 WC1d/2yCCRmUw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1smadP-0000000061d-20F8;
	Fri, 06 Sep 2024 17:12:28 +0200
Date: Fri, 6 Sep 2024 17:12:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: serial: pl2303: add device id for Macrosilicon
 MS3020
Message-ID: <Ztsb29fnHyTONn-W@hovoldconsulting.com>
References: <20240903150638.3850030-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903150638.3850030-1-bigfoot@classfun.cn>

On Tue, Sep 03, 2024 at 11:06:38PM +0800, Junhao Xie wrote:
> Add the device id for the Macrosilicon MS3020 which is a
> PL2303HXN based device.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>

Applied, thanks.

Johan

