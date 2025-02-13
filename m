Return-Path: <linux-kernel+bounces-512320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE10A33793
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C62E3A8EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE937206F25;
	Thu, 13 Feb 2025 05:54:13 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D866204F85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426053; cv=none; b=GhtQS22SEKXmLSx9btrsn1aiUzxl4GBER41I1IVhcyVwSGSXlWLrfkqc9qDO50Qs3lloP+5e5zcn+hwcUs109fsBhI4vxSDvWOM0zYnVMLwliAZ2rUlNJJrk1d6ytx3kpKn9s55QD8Y2cYlxONekhYAqWAqvoPeH+N6qzNDlC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426053; c=relaxed/simple;
	bh=pBISwe9wNSb/gfix9O6ND6TUA17jgJ6yC0jsbGdB+Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHxvwUqAWZ3WBvSRPrByVrfNU3Fdcj+CX0GhWSyRWMRe6bvitNbW8G5sr6RGhN9Geo0gx2q3j9uEsW9FVS6A5laeS9Y8OoL2VQAboJAJtQREkTG9gM1yKTovTdzAngw0o7z7E72Ep0GFcX/Gru5sqMYfpRRQRT41xlZWmE9w3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66BCD67373; Thu, 13 Feb 2025 06:54:06 +0100 (CET)
Date: Thu, 13 Feb 2025 06:54:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme/ioctl: add missing space in err message
Message-ID: <20250213055405.GA19370@lst.de>
References: <20250213010917.3816029-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213010917.3816029-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 12, 2025 at 06:09:16PM -0700, Caleb Sander Mateos wrote:
> nvme_validate_passthru_nsid() logs an err message whose format string is
> split over 2 lines. There is a missing space between the two pieces,
> resulting in log lines like "... does not match nsid (1)of namespace".
> Add the missing space between ")" and "of".

You might as well consolidaste the string to a single line while you're
at it.  Otherwise this looks good.


