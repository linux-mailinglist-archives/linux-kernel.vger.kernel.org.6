Return-Path: <linux-kernel+bounces-570765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0CFA6B44B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54F1188A0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5541E9B18;
	Fri, 21 Mar 2025 06:14:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE022611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537641; cv=none; b=WgGDJ6XlDaBp9ctNu79AflzWQ5r9CqEEBMx/FW1XHEYi88jy5X6OvCtj/UB3qKEeDzbcgXFx6KIGWhBjql0Z1ToQsE+0C/Owqi//uJRJS26hV+ty4uJ03wx3a0tcg71AgywoW6LudAXZHlOP//O1WzQ6TqneTy/6pkj263D/qJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537641; c=relaxed/simple;
	bh=GcTgQJ39rfqCld+0Gddmc5NrRIS1k+5z6I9oumgHG0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2/xrOZbCyPQDZjTxt7W2+DjQxZVmzvXi0byip1dIoCKZf2CYaGLwNNTDK9sChw19vHZ/tJMKhFhjI6O+fta6GNReSK61jBUulDm3dRuQxhrTMUAinZD/BbHgwXoVBUD1Ij1XBQbHNbohCIafdl9zs3p6iv1PCSut0TfhtGMVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CAC768AA6; Fri, 21 Mar 2025 07:13:55 +0100 (CET)
Date: Fri, 21 Mar 2025 07:13:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
Message-ID: <20250321061355.GB3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:03AM +0100, Daniel Wagner wrote:
>  };
>  
> +#define PORT_DELETE	0

The way I read the code this should be PORT_DELETED?

Also maybe add a little comment, once we grow more flags that really
helps.


