Return-Path: <linux-kernel+bounces-321682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B89971DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410EF285221
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34013A1AC;
	Mon,  9 Sep 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6qibeLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B61CD0C;
	Mon,  9 Sep 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895328; cv=none; b=VpUpbBfOaTKM8wrEfIXRruUI9/qYS/kZq1uUWGQVfIymMWzxsks4Oz/OGVYKSgYtjL9Ttn5HC9/7KEfY+JbKAeACywkfK5LSCRjjsEc+DsRXb5nA/OFdaK8HM7ApyYIesq4d5p5iaI7cDLzcGJyBIv7B+BDyzFOoca26xDvTzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895328; c=relaxed/simple;
	bh=bTBlKx6xdkIC07gpKsZPrQr15u94j3imBnEBorbPhac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm49Wb7tgI5WzVa9wMxsGclkurz/Fy0H+hiQ/5B4lu4xwAKCraQKfe6QsD3K+9MIKJ6XHMkH4/oWlFmX6ZWOPrHenJpRjyV0g1S1ESlIHN8gRBXFiQ4vOkFS8IN16nYXC4FSpOi/d9EPPOpQR5zTyOX/K9q4jSBQkba2KjTStAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6qibeLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AEEC4CEC5;
	Mon,  9 Sep 2024 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725895327;
	bh=bTBlKx6xdkIC07gpKsZPrQr15u94j3imBnEBorbPhac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6qibeLgctF7h/83sDNNoXuvFe2Anwoyrk/YHSzcyXyS3XzJNQwqgDRllrAklASAE
	 TH2vvAzBNk3ymzG+IlkoCGc9c9iJX2BxrTEb/BiPj9IBmXgzNAhF1nynkaRc9h6F0/
	 ID+CXOuav6IQDF1LWLCJGz3loBcfDW5JyUHawcoXKDXA/YOy9MYzi2cUsnL5L16VSm
	 q6kolx5oZuN+bFAYwmSKByM37WUqU/+8DOqJhCOgzSuqKu/ZB8SQYTXBSiatYzDsjJ
	 /IOCBBU0rdZLevUEcr2UKMNVkw8xvWuXuIT0bvwbCTxlu6cwFV+LWvX6ydR8YiGDUl
	 65NDAUyEe7JlA==
Date: Mon, 9 Sep 2024 16:22:04 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2] MAINTAINERS: Add ethtool pse-pd to PSE
 NETWORK DRIVER
Message-ID: <20240909152204.GA2097826@kernel.org>
References: <20240909114336.362174-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909114336.362174-1-kory.maincent@bootlin.com>

On Mon, Sep 09, 2024 at 01:43:36PM +0200, Kory Maincent wrote:
> Add net/ethtool/pse-pd.c to PSE NETWORK DRIVER to receive emails concerning
> modifications to the ethtool part.
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


