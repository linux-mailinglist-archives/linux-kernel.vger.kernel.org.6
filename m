Return-Path: <linux-kernel+bounces-546998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0DA5019C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2505173260
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61A2054E3;
	Wed,  5 Mar 2025 14:18:29 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BD15746E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184309; cv=none; b=UnOjHtUR/taHtYtBbA1Hl9CcjYot0umZItEG3CeevNfPBF93PlyR+AcYe6O2dVBnvG0Zw+2yC8L1ZnQIxlU0i0GYDdWeJOFKxtPmwO2KKRod8tQLqQIu2nUsVxIUHXcb5Xh/wD5oW/zVEH4uSvIUHVFt/CSli6EFYShSCNs1jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184309; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNJCEqMtkSEOlk1SAkbzWAE0IHYLHIuUVOSKPmyBrrcvaGg+CeKhCMznJj0foUc6Mk8ZogzaF90Y9+3zXuvizA7O/O8jiZc4mKjUbgJ2n9p8znsiJFNotl/SUVHQi7FNBgs03++AyVmVpkEGYZgVz0Ydc5JoNXTjfe7DbHox0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A64C668D05; Wed,  5 Mar 2025 15:18:23 +0100 (CET)
Date: Wed, 5 Mar 2025 15:18:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <20250305141823.GD18065@lst.de>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org> <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


