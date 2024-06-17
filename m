Return-Path: <linux-kernel+bounces-217080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC390AA51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD6E1F21CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD8196DBD;
	Mon, 17 Jun 2024 09:49:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0014F196DA0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617761; cv=none; b=rWdrONDru+hOAv02YI8ylQOkwHS9uVOp/kephsO9/PnE2Btq9yTRE4rvpX5hq6IkaJRk4jWRfgq6cv5FAUbuXeb4+1F8m7v349rYQSmuKgDOCdKM8DA6yucxlF8D48Ee8u19Z+XcJZdRw7K4ZNCB5G54qZGymHFQxDIodjV0OR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617761; c=relaxed/simple;
	bh=u6i2aYM0agTppfJ1moGlnE7LPse7lHTTOBmXc+irqzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB3K85Sw8225VMcPK9bVdj6qN5gyGvGXzt9xdAnI10usmZ4qndp/Io8803mW10wA8hFILSll2vJEPbzYoGn6+R71FKPr+xaUzxNjccqsqRsPmlB9aeZo2AYLEowFTNZdvKY7Sbv8NWQ4Q8AADwRLiDSopXY+rjXuSFP8UN7Tsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BAC4DA7;
	Mon, 17 Jun 2024 02:49:44 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC3273F6A8;
	Mon, 17 Jun 2024 02:49:17 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for SCMI drivers
Date: Mon, 17 Jun 2024 10:49:11 +0100
Message-ID: <171861771384.3837937.10329416225548554445.b4-ty@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <a9706e17-09ad-4304-828d-c0987befc8f7@moroto.mountain>
References: <a9706e17-09ad-4304-828d-c0987befc8f7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 17:57:18 +0300, Dan Carpenter wrote:
> We have created a new mailing list specific to SCMI. Add it to the
> MAINTAINERS file.
>

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] MAINTAINERS: Add mailing list for SCMI drivers
      https://git.kernel.org/sudeep.holla/c/08070351c878
--
Regards,
Sudeep


