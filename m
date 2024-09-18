Return-Path: <linux-kernel+bounces-332609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E797BBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7DC1C21387
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553817DE35;
	Wed, 18 Sep 2024 12:03:57 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC503C3C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661037; cv=none; b=GaxDfVuFfjCppgLNBv8MAqpn+mLqBKL7llr77lQ7wrBi36QM6v+7M5A0dze5ZWoGsJoLxNAsgEG+eRie+iiglcwh2w9PazLU89By+2AerY0o/lV9y6tx45WOmgftFmGkX7NPwGZEsDoZCnnfYIEtd9XmWyqY3l+ENKdGtx/5MLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661037; c=relaxed/simple;
	bh=qH9stToMqk3SMsag+rAXvfNzqj12US92NzTuc5WZtvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xdna2UArVcLisjZRFpW53k4uVYNc+BkIPwzrVgwFPvP4hvXt+t+QyNLttmQYYPjUVi3maJeCs3saguI6UmEsKLTzNZNqpUzExIzUnmadtaUh1lSoHHI4TWQxZBwRsvOcSnKk4olPbS5bJ+J9PjNiWQdWXHfVrrj0K4XEs0cPHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DDA1227AAD; Wed, 18 Sep 2024 14:03:51 +0200 (CEST)
Date: Wed, 18 Sep 2024 14:03:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Fix warnings given by checkpatch
Message-ID: <20240918120351.GA20881@lst.de>
References: <20240918081134.908075-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918081134.908075-1-roheetchavan@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Please don't waste peoples time by sending checkpatch cleanups.

Good coding style is nice to have, but unless you do actualy substantial
work in the area that has issues it's just churn that creates work.


