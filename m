Return-Path: <linux-kernel+bounces-306566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B268964090
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1551C242DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2118CC1F;
	Thu, 29 Aug 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrdouILi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2118DF67;
	Thu, 29 Aug 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925125; cv=none; b=cTvR1rZFQnNlcuzRHCtnlcpbXZ76lbZvXuixrv+besS5fNP57ATDX4SNVqfbwXwtVvRd8JUXe096/zVlU0tg4FHetjFw2BU3HqrEBownnvod7a7kpgliehH+OaEsErs04AzksgOX/XWPtBxN9NkHf2yLLo5+OUNZIlzlyYijUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925125; c=relaxed/simple;
	bh=J9DTiP8UMeZe8eRcC17CHuggrKPYzMNPsas+GW1C9Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIOMZFJF2+rWwnThox2/RuKsDqY0p/0Wkrare9F90sksryHgC1+IAEnPusoyvazE3zk04UOfOojSCVHxLBMz5sO8mNu6WcSn73BzMs6HzGFq7/DWQyqD77sioS3A/j/a9qKnhYtvJy2B5WYluDA9QH/N+MtuLvuV0SfNzyaoo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrdouILi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2C6C4CEC1;
	Thu, 29 Aug 2024 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724925124;
	bh=J9DTiP8UMeZe8eRcC17CHuggrKPYzMNPsas+GW1C9Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrdouILii8mhbRK4SzfPYw97YuQIAH7eZgXE7lfThN69NA5XTTpHuAfGsIGJm2tsW
	 yWRo202aAVZKaaiP2p0ArWRpCRntq9hLZdwtEfdnM9BU40uVncI15OQ/Kg/2+bI/oe
	 Nj3INcJSw9f6d7HU4zRzELBQQTGw7tafK3T2NGpo=
Date: Thu, 29 Aug 2024 11:52:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nilo Alexandre <n1lux.comp@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v4] staging: rtl8192e: Fix parenthesis alignment in
 r8192E_dev.c 325
Message-ID: <2024082950-goes-footing-5714@gregkh>
References: <20240828011842.67611-1-n1lux.comp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828011842.67611-1-n1lux.comp@gmail.com>

On Tue, Aug 27, 2024 at 10:18:42PM -0300, Nilo Alexandre wrote:
> Remove linebreak to improve readability
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>

What is the "325" in the subject line for?

