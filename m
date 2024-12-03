Return-Path: <linux-kernel+bounces-428551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69029E1082
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48022B24636
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260915E8B;
	Tue,  3 Dec 2024 00:44:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73652500D3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186691; cv=none; b=glb3qBlt3CCg7dK3NQXFZdn/aSv+J7OSucLDej7xWjs2hZO1hDcIEvuTk11AJBJTTx5nZ403sbG4p4uJcTOgSzhyZlcOcciZMXMPTMCIBH0mDE+hVk+Fb3it5CGzN7RrVoSX39llwCLsQcvMSpx5QwCWACBkxejZWTSVdhWH0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186691; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSWVV4rieBidjUZaoCOaPuFHkiMzdrPWn+W577jy/os6XlMAicp6lD9NB+OK2kbwdR6G29BkPn2qjpo7StAAbOU+2UIV0uRUVBZ33ewhgQBEl8ykuddPhMuDEEILvuBNS2sgy0v/qeXHa1WZZDhmlm4EACq8cZfxy+fdaTvZWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D803268BEB; Tue,  3 Dec 2024 01:36:58 +0100 (CET)
Date: Tue, 3 Dec 2024 01:36:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data
 allocation
Message-ID: <20241203003658.GB7439@lst.de>
References: <20241130170258.103954-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130170258.103954-1-eleanor15x@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


