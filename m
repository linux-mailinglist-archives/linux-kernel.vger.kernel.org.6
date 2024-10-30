Return-Path: <linux-kernel+bounces-388110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1C79B5AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57CB1F23A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B842194A5A;
	Wed, 30 Oct 2024 04:38:12 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221018F58
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263091; cv=none; b=Z9cnaDZdtYOHxTWseFzjntwRcGqcIHT+EACA4KPJiyw0N+t9b/0OeJZ+X+XvEVBRH4kaIo4zBCJ5c+qdnifWdzUeX+13iJcG2l7N5oRejTB06ecBc1pq+ecVY6BLxOc9TjClgboz3pp3jHGL7Qhn7ti79p81yJn6A5nF44bgyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263091; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b82AvKEjfJKwpq1NW1RCYu3zoaWIAA/tTDCql2fOzcToU+h4PyNu6lcsfkMoeRCmA8UTUSHcXT6duMcw26qaLVDww8U+XIJHOtwFcb5MCzo4IMt53h52UaRYXpJ96XOYLP3PtiqdYwRsnH2doN/ssOeufMZeLtK1a/bDzNpMrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B764227A8E; Wed, 30 Oct 2024 05:38:06 +0100 (CET)
Date: Wed, 30 Oct 2024 05:38:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Message-ID: <20241030043806.GA32190@lst.de>
References: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


