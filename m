Return-Path: <linux-kernel+bounces-408693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09A9C8261
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F15C1F2437B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CB518C02E;
	Thu, 14 Nov 2024 05:31:54 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348F33FE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731562313; cv=none; b=IkAIzzbodpiDhVwqnuP2D7+FVK4k30h6gvPpS9fsMI2dN1NC5LNfE78CwuLWs+LiLzXw2ZT8p4qWPo127I6zoLurXg7Ia7N6vkA6HYq+n0twaFO/De6qBYXopVqMFLE+/1HMtQvTciFXNmrpxuMN9Ax5HNIcbUXfhm2mijrlOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731562313; c=relaxed/simple;
	bh=pEaEjE4iIrNTObBC0FRBEq8zbYZ9c+IfGg+ZDDhTkxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQzpF5/aBuLawN6Z7JfZ84rVVSpzqVdAtk8Zd0AYhEx1+0fV8MZBRgrT3oUAWXDhmWznVRu0I1Agc4M6uttXS9Iw/5e/IbhCQ0zMhhGdiqcJyi3foganIZuMSy6bVKFNx9ZSeTqajWHM4HEpKHLmxRcAZxJaKfhHa9zWo4hgLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B184768C7B; Thu, 14 Nov 2024 06:31:47 +0100 (CET)
Date: Thu, 14 Nov 2024 06:31:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: Remove unused configfs_hash_and_remove
Message-ID: <20241114053147.GA10563@lst.de>
References: <20241010205655.278385-1-linux@treblig.org> <ZzPKbY3n9gxHebJl@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzPKbY3n9gxHebJl@gallifrey>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi David,

I thought I already picked this up, but I didn't.

It is queued up now, thanks a lot!


