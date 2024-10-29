Return-Path: <linux-kernel+bounces-386870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 949459B48D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F621B21C06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70E205AA4;
	Tue, 29 Oct 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCWZRPwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F342010E0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203364; cv=none; b=jXkgMvPHBOVkyxMjYnh9DAWPMG8eTRvsErxvMdr00qUadUt9V4bPrxzgadMDmW1Chwu1BwNLDj8EuXqWSVNQkKFli3pY8RY+NX78iq02mD6olM7rQhbpi3Db3RvVJ0Dt+nCmoBUZnMxImTyxm2+6Bk3zhE9f7+jlUt14/I0c/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203364; c=relaxed/simple;
	bh=dG1cg1dJkX2e5KP3A53ABfFuvOvbm+UCDsTxRwGIVMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd5H1UbxfxYBNCYA4eGMkuRNIlXriSpsjwkaDSAv1oG1/MqEeAUrY64ZTkQ2TKkitq4Ik0jY2vtSQO97vKh0pDyv/YCgJ1K8w02clAJjEROKgUNVY2J2tkyJZcvy3pSJRmqqx3OcE1kyz8hFnlrCZu1j+5LtrltAB0T2PM1Iw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCWZRPwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C5C4CEE3;
	Tue, 29 Oct 2024 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730203363;
	bh=dG1cg1dJkX2e5KP3A53ABfFuvOvbm+UCDsTxRwGIVMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCWZRPwM1sVJhlsj4jYJrJgo6Hs0puvkp/39PpZCyHCOGSgM7NEz7Anx/cs+3ZWDW
	 6K91PfenzguJkTBuF93jYc2PNcyA6gLVVDX2lmpFrhnRHdqb6iMn4MqFnCeuIG7xiH
	 IWIoRT9PCPgGOknplB0GI+gONj/Qu9gyujkMMXpT+XhwDvC2I93jNpaYR6j2ynTjQ9
	 /q4dlIeG+qBOhqs20hbCTXMvirwktPKmIQaHwf4tizFm3c4QLo8d2vboQ0JhWznFsJ
	 waKsHkmxnK0dvH3y1AauIyy9FKEenUdw7eQRxQlwaTt+67ZdU9VDDPAUd1ajI973DO
	 5zZPHx68qOJ1A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5kwA-000000002ja-3KOs;
	Tue, 29 Oct 2024 13:03:02 +0100
Date: Tue, 29 Oct 2024 13:03:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Danzberger <dd@embedd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gnss/usb: Add U-blox 8/M8 device id
Message-ID: <ZyDO9lTmJmnQ1nJO@hovoldconsulting.com>
References: <20241026075857.3651161-1-dd@embedd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026075857.3651161-1-dd@embedd.com>

On Sat, Oct 26, 2024 at 09:58:57AM +0200, Daniel Danzberger wrote:
> Adds support for U-Blox 8 GNSS devices

Please post the output of lsusb -v (or usb-devices) for this device.

IIRC this is a USB CDC device, which is already managed by the cdc-acm
driver.

Johan

