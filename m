Return-Path: <linux-kernel+bounces-400999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C48A9C14DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC551C21346
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C619E99F;
	Fri,  8 Nov 2024 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KCKsyoBB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D32629F;
	Fri,  8 Nov 2024 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037825; cv=none; b=igp2MIC0t7RxXBTq3wCokYtJ0qTj/cTZrbJ3IULyd6uM3Nd2tCqm9O2EPUPWGJup3T1bSGR7aEqSGaROdK3+VeaFNBXotDV1ieCRjJZL8ZGUhF5PCeeYGZSUJdhyzJS5Jnk3vRj9cv6adu5Hn2VVn0ENabuBQhD8vXZOsFVVJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037825; c=relaxed/simple;
	bh=yqSHRVeNmHrmnfbgRFpF8i92uiCP+7zXrBUrKswVUOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnBrgFHJ6opmaDYoqPiUL8ywHNUL/Sz08zW24+OunvOxBMFxaBMkvtw/Mzk1SNsqQda0J28NnuevUFavEwqetxInt15wcP6JAylCwGv6uARoGSr2DFEIg5LgtoTZGMAxNErqOomGQByip58xBmmJGxFTm1kZXW4HVL22b4iD8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KCKsyoBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB65C4CECE;
	Fri,  8 Nov 2024 03:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731037824;
	bh=yqSHRVeNmHrmnfbgRFpF8i92uiCP+7zXrBUrKswVUOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCKsyoBBmleaX2pxrTHpeUMPnAXtGevKClNFMp216caEC+wclOR1qbQcD+MaSNU1R
	 Bc/riLx4ti3PQM4ghzBr2rs8tbg3kCOIEISsLj/xFLgaqGx0/dN5OLe7lAWGmBGh+s
	 Gxhq4aNDdVy3VS1ullOcQ4wQ6uWM3zUIdcpkjPf0=
Date: Fri, 8 Nov 2024 04:50:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Cc: dpenkler@gmail.com, arnd@arndb.de, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: gpib: gpib_os.c - Remove unnecessary OOM
 message
Message-ID: <2024110805-lived-grit-433c@gregkh>
References: <20241107213813.19185-1-m.omerfarukbulut@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107213813.19185-1-m.omerfarukbulut@gmail.com>

On Fri, Nov 08, 2024 at 12:38:12AM +0300, Omer Faruk BULUT wrote:
> It duplicate the MM subsystem generic OOM message. This patch fixes
> the following checkpatch warning.
> 
>      WARNING: Possible unnecessary 'out of memory' message
> 
> Signed-off-by: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>

That is not what this patch does at all :(


