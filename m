Return-Path: <linux-kernel+bounces-437704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996A69E9750
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A1416520C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB3233144;
	Mon,  9 Dec 2024 13:36:47 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A2233129
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751406; cv=none; b=kfcEdGP3q7fDV2rLF8PzTUK5/qEnRxBol3nNFI3XJL//kuX2SRctrq97XQla8MTGW3RZ+caM9+yiHNEGyGTVFNraLDqSnc7JmB57zMi5YpTM8rWrxd8pSb38O/cJ4e+rxEZvgXy67fGP/lFhKDDnfgkZncNBRI3g9P1FOOtYJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751406; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXOiH8T3J/ztiik18hkM+fm6589U5fGRSY5BEoI/bXfb+dLpyWOHIJ2UdsIm4ygQnj69gr3MC80aqeJgyTsQJGqUDiPwtMr157nNgSod9OSSvqvA5NICA8gU+WtK2aGC3OpAwByzgEGhYu4M7J7Mqovo+LCU/u1rxCHd7QcsbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBE0868D15; Mon,  9 Dec 2024 14:36:41 +0100 (CET)
Date: Mon, 9 Dec 2024 14:36:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
Message-ID: <20241209133641.GB18172@lst.de>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org> <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


