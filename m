Return-Path: <linux-kernel+bounces-557842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD118A5DE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C8189DE53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3C1DE4F3;
	Wed, 12 Mar 2025 13:57:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683A241678
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787842; cv=none; b=qZx+3eOytJk0mGkp+pQ9rbGog765fjGFP/fGkxXReSZ9Sw0uHMQ/0TuXTdVbAXnxecnEAecAKqm34wDfTlcSFF8RDJ97qC4Fz3ZgOCg9Enuhdm/EYq6VKpunVaQccnaxA4LU8asmSCsqSaa1/gqSuO/4xUKLNs6iqJejiDNe0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787842; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2/jjxcG9DTpeYW1vHvzVn8tkkcoGyxDGOOJKnRFjmLOW74XMIca8hDdFWzICKTyvXdsZEjIEB+zKUtTnC9swHdEOkYCEb3u2s8uFQuUcg+nW4HI+mmI6epe8iDb9gbZtNWzJcla24/uF5r6YGheqqV/Gao4iHFw97TU+H8Q100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA40E68BFE; Wed, 12 Mar 2025 14:57:13 +0100 (CET)
Date: Wed, 12 Mar 2025 14:57:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()'
 calls
Message-ID: <20250312135713.GA12488@lst.de>
References: <20250312085625.1624394-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312085625.1624394-1-nichen@iscas.ac.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


