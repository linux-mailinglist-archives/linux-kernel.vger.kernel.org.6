Return-Path: <linux-kernel+bounces-518904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA6A39605
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175423BA66A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97B22D4E9;
	Tue, 18 Feb 2025 08:42:31 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FC14C5AA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868151; cv=none; b=JpS9eNe6+CIzpvsDj5jwpIodHkJU6AzZ+Z8F75zFUG69re1F5LRxX8BpD+jYQpKZNX7WJ4T5BUVaPAOJSlZmWeBoerqQFoiBp45cEpO1EVL6sZmPKd1ZvoxCopuvRWH5HJnbNmprI7Ghn6R6ech7nUdcfBQLzr25pzqaYDTO3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868151; c=relaxed/simple;
	bh=V6b++hp+qnjJR0ez2dLHBKIaVA93WeeFSyXk1yt9LCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfW7O7QjP1C0D9v1nvT/PqBsiHSe8X+fjq8CIpbR8V6R+WmlLyqtQW+a0Chxh5gs5/RvkJLueN4XRzr7IQSwkPcjruv6dj1eQa0W/A/S29t9cFIxQq9+rt5pCSHeuDolJjaHiy2WDukbTnI7T7ZfArWDHqEDysYwcr50fKz2PYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3726F68C7B; Tue, 18 Feb 2025 09:42:18 +0100 (CET)
Date: Tue, 18 Feb 2025 09:42:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christopher Lentocha <christopherericlentocha@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix two Acer FA100 SSDs from interfering in one PC
Message-ID: <20250218084217.GA11129@lst.de>
References: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The subject line should rwad something like:

nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

and the commit log should be wrapped to 73 characters.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

and we can probably just fix that up when applying the patch.


