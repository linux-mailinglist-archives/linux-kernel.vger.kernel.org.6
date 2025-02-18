Return-Path: <linux-kernel+bounces-519769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC1A3A1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617CF3ABD23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346D26B2AC;
	Tue, 18 Feb 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhFr+BO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66575199239
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893563; cv=none; b=Kko2SoS2sSbG7tZN19EuFycOn7p+sbyBJv3S4BJhdzNvUihDMVRljbzhU8ItBcRrhjUikrJqcHT9yC1RnIcdUPv0oAUVZafIuAYCC6SxE3fdUau5a/7voevpdQ0nOb49yEoociG7HQ9+BbqGkC5UDT+A7svSJGdj+mizrNtsrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893563; c=relaxed/simple;
	bh=1gHhFQoAATtseknrD/eHDw3a7Fd+vr21xju6PhOoMdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYqP6HPibg0pzO658Wco6daBWK5G05FmpuFmbxe5jOK9+SsYVEhxC/Uxtltb1hTd5WavCat2BtPHIty4hK+I1jZVu7H18lSemHgLC01ToXg6tbsyPqqMLMlijRr75+5xoYClJaf8BImCsJxjZFixnwHjlguxu0mx/a3leuuEBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhFr+BO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE53C4CEE2;
	Tue, 18 Feb 2025 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893562;
	bh=1gHhFQoAATtseknrD/eHDw3a7Fd+vr21xju6PhOoMdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhFr+BO87kwK+jpe/Up9foGnMN+gxtagwcY7emlV4beMzZX2u9fWjw/2SWLVPD9yU
	 1JlSdezBEtOHLbR2F2GGmcBTjdZ07U/2HkB+9BDjcVqY/Kf8CWgmpfdPox8fU4GseZ
	 2K/L8Qv4rq2SxskgK1hGPnBhdlnV4cLQN151DW9RAJIjqCP+MrCvrimBqRY4qHDo1c
	 Y5voWO0rQ/k0DagQcMdLyM65oN+yGWUC5DYLxMI1vLw9FgJR9I57kBZlI396XSMDve
	 1gjXbn1u2kO0pVeq9R+DwhmF4A1HeBNxJK3ZAQBNX5TC/HS4HKV13/E3l1UmN//SHQ
	 Q/0rg7rmdNfrw==
Date: Tue, 18 Feb 2025 08:46:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme/ioctl: add missing space in err message
Message-ID: <Z7SrOM65-lgtLC9T@kbusch-mbp>
References: <20250213170515.4027908-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213170515.4027908-1-csander@purestorage.com>

On Thu, Feb 13, 2025 at 10:05:14AM -0700, Caleb Sander Mateos wrote:
> nvme_validate_passthru_nsid() logs an err message whose format string is
> split over 2 lines. There is a missing space between the two pieces,
> resulting in log lines like "... does not match nsid (1)of namespace".
> Add the missing space between ")" and "of". Also combine the format
> string pieces onto a single line to make the err message easier to grep.

Thanks, applied to nvme-6.14.

