Return-Path: <linux-kernel+bounces-547040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32382A5023E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8388A1898E48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8394250C02;
	Wed,  5 Mar 2025 14:33:45 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBA250C03
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185225; cv=none; b=OuU1Co7M5lPe4i1a9LiBFF0RQa/Uz7vKNlrAuSw2xMXCxnscq5LOa/uL8v4Aa7kllgOuLdsKt3yrm2krFMf3DIeY2yJ8DScGwGQuy0G1eGRmK9Xhp7l7MHO8w9miLeJD8Bip2jMZdLeh9vhEklxt7z8gJEmnFiesUIta83mBq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185225; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8S+Ry+HgT7YH3pnHMCAARIMFnWnx9foLq3fpgEEcFbV1x9DH4Byd8a18viK5kh4hhXBBHgRWs27+BCuFU9eS0uwxkWXICmxo+fsnqD74vHntP+AKxQDVX5+NW0x4R/kJSBTpUDiK4a2rUHRycFGRbQtV0xRyiA0NVZfZsaYZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CA3D68AFE; Wed,  5 Mar 2025 15:33:37 +0100 (CET)
Date: Wed, 5 Mar 2025 15:33:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 1/4] nvme-multipath: change the NVME_MULTIPATH config
 option
Message-ID: <20250305143336.GA18526@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-2-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228032541.369804-2-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


