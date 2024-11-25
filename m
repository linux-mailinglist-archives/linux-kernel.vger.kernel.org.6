Return-Path: <linux-kernel+bounces-420973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD19D84FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050DC28636E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00656194AEE;
	Mon, 25 Nov 2024 12:01:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AB13774D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536059; cv=none; b=qy/c2OmA/9fTIzfpKQXVjmiDXQayRzUC8DP61hPGhewVo3ZLAyREsLe3hCXZYKuWBf4Uj+1Hup86g6loHO40T0TQEMcoPPhzf6ec1WD8+eNCfqaGCD5MGuT27Euj9f7Nbku8ARJr2hh5JDVrhKHuc/rEoyTa/SDgnuxyKVkuvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536059; c=relaxed/simple;
	bh=b2V3vqiuyYpFlU9oHbiyMBNISTrvBwSaEWht3G4ch74=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=de3Aucoz0XFMYzzZij2eEbjl3azol8AlFnns/Uv0fbf7Sb/QZUVNgLMeqAL8qyBLrAMvw69FAXKqL4bNeJTQVPsl1L85DDAOaE+pTw6otmEqVgX4VpcOyuhP5pFYbZuifMYZH8iBq/zUg6n1pANtSmAUz6eMTC1R6Hf07wgY+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xxkhh6H01z6J78S;
	Mon, 25 Nov 2024 19:57:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DDB6140C98;
	Mon, 25 Nov 2024 20:00:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 25 Nov
 2024 13:00:55 +0100
Date: Mon, 25 Nov 2024 12:00:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 4/5] acpi/generic_event_device: Update GHES migration
 to cover hest addr
Message-ID: <20241125120054.000036e8@huawei.com>
In-Reply-To: <9aa962a596769f5fa35c8af84b5a522cb12947f2.1732281080.git.mchehab+huawei@kernel.org>
References: <cover.1732281080.git.mchehab+huawei@kernel.org>
	<9aa962a596769f5fa35c8af84b5a522cb12947f2.1732281080.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Nov 2024 14:14:14 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Not my area of expertise but looks sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



