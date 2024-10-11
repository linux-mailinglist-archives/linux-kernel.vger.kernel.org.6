Return-Path: <linux-kernel+bounces-360500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09317999BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C302864E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783821F4FD9;
	Fri, 11 Oct 2024 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdHpogs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09551F4FD8;
	Fri, 11 Oct 2024 04:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621645; cv=none; b=QgZgn/1KMa7+595udihQZR9LzBNOhIZK1QZk1GcfQ++o8qrl6CCJcmAE9QnOIdgaWs+1WE9d69HSmUd0Qy3DYtCn7Ax4eXow2bsdVeyX8H+DbCi3f5p4M518RVg17F5VGJd5+A6/9yotfextZSPbry5jHEKhouWlLz4H9m42WyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621645; c=relaxed/simple;
	bh=bp6RkYNXwFrkU9oUwRZiRw2nCvBY8jOTnGWO4ymrtII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evwodZTeFMiLv0axoVvNYgydjFR6bBvxnJL+hlamk5WqFqybSMtLuCKeZoclB+lxW9+3mvt0EEjVmq3NQJneuZEB226OQRUQlBq8mnJT83s3QALQsFpIDJt3TdY9G9G776J0jq6a1lVDLpmxcZaWzqkeaVvHkolkkObyHCYILMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UdHpogs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C444C4CEC7;
	Fri, 11 Oct 2024 04:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728621645;
	bh=bp6RkYNXwFrkU9oUwRZiRw2nCvBY8jOTnGWO4ymrtII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdHpogs7Yiep4koHAWQKSqE+6i+tu1k40qUj2+uz/vTuKrPSfJpx0wZ7WOXB2luXb
	 VpD2kXJHaaLtfL1gC5xY3s9ooNgNR/GyMMSrRMF8WOjkt47GUaMXkFQ6a/tCH6E0gS
	 kN1fhF+axfoCuWH+G7GCBclhpPsn7pJmdQFUJe5o=
Date: Fri, 11 Oct 2024 06:36:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/5] staging: vchiq_core: Reflow long lines to 80 columns
Message-ID: <2024101117-drew-repulsion-ef6f@gregkh>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
 <20241010102250.236545-4-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010102250.236545-4-umang.jain@ideasonboard.com>

On Thu, Oct 10, 2024 at 03:52:47PM +0530, Umang Jain wrote:
> In order to respect the coding style, wrap long lines in vchiq_core.c
> to fit in 80 columns.

We can go longer than 80 if you want.


