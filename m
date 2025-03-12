Return-Path: <linux-kernel+bounces-557239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAFFA5D580
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9631D3B4B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7F1DE3BC;
	Wed, 12 Mar 2025 05:23:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44732F9D6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757038; cv=none; b=nVy4SZawT4mLpFwZboBGDWZD3MwfQxXu1Ie+bW/yue9pKA2UrQoaCiZhXOxZnNFJ2IgCzu3KCnewTjYC2wSs6omifRH0OSv6oJCeovS6Gik+RSuAEAddb3gGGfYtVukXP77Ss+RP1i+WbGsmRwn/xjJlOyzc9PEq4FG2lU3Sq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757038; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/zWK08+73+l+U78px/pOxkfhA4ipwF6juv7GaT2h4PpxLyqoI84WzZKTEPJDb3ottdIM0yGwlGgL0gk9eY1tRp+mIyovH8hUKJ27TH2zx2Ql+NIJN8MJDS1jL9hc6WqUVBcIgMNrV0fR7tLlixpaWBZhO8Jotipf8Qo1BD6CYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CFA168B05; Wed, 12 Mar 2025 06:23:50 +0100 (CET)
Date: Wed, 12 Mar 2025 06:23:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	james_p_freyensee@linux.intel.com, jthumshirn@suse.de,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] nvmet-fc: Remove unused functions
Message-ID: <20250312052350.GB11864@lst.de>
References: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


