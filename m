Return-Path: <linux-kernel+bounces-249206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE992E87B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F5E1F22DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8CF15E5DF;
	Thu, 11 Jul 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="OdVxX5X8"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B315B964
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701875; cv=none; b=hm6VGwxH2upQdexNAy/xCdQMSHGGr7BLEPm32g0QiwzEt2tM5f1nZxmtPMs6iRfOxq2Dxl9Jma5oW9N11wQIfqFBalPmR04HfmmdSgyhfi7xL2nxtyT24Z3ro6ViRRvJnzmJDlahKh5uvliMQA8mNPy2e+akvPqnPVFbV3T5pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701875; c=relaxed/simple;
	bh=gJTw/Zm++6Ib7sOCxiaEEM5QS3JS/FCE/tLsrQn4EMw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VCfEajY8m5mOUSwu9ipU5Kn2grKxdq9l4XoB1bsJfVlOQRvnlI09i6+ZgherVAiBq3ClMazjPUAUVIIDKuiLGLSgYW3Rnru9ETqfjFUOI9y+PtgVpBuZKQiilbW3Zd1O+w6mqDLMSKbwbnwXl739Af76W+HbLwBZRoRXp517vV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=OdVxX5X8; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6K1HahYa0DMDdJYagFdtfN7sso3yxWDerOIaoGmqSRw=; b=OdVxX5X8hIScX0dMLq9qtpK/v+
	tlHirvlo2nvkhHArBxxJZN2BEdFQ/iTeqBbcsSlc4aKn/dXECwR8oLqsD7JiXHG332WsWZtfcH/l7
	eV7VaBcTw/N/c8HeP6WFd3Z1HO05B5cJ93JdBbZhbART7yWOq4/XPQfGRfaJc4vWrMclRSXOYNqJ+
	5lMKv05JzjGfuDluVZt3UWLjQNuVcGBKNGRsZRH9r6Ir8OT0egdZlUJ9wwOTddo2HwuylP4TKZMHt
	zY3SfOCNSABX79lKcbxcv5GTx/rRjhVeAWidFhJW9mgVHNy6+q0tiBt/1A8uCnOZaWFd/y6gc9Zwf
	CkNmz2kg==;
Received: from [2a02:fe1:716d:5f00:8974:c416:9b58:8637] (port=52981)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sRt9u-0028I4-42
	for linux-kernel@vger.kernel.org;
	Thu, 11 Jul 2024 14:44:26 +0200
Message-ID: <1ef8e402-a55a-4574-a9c5-bb49bc27c890@malaika-12.net>
Date: Thu, 11 Jul 2024 14:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: Statute of Libery as an icon of The Vast X, Opensource, 3d-printing,
 related music culture and more.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The Statue of Libery could indeed be a good icon for The Vast X, 
Opensource, 3d-printing, related music culture and more.

Including standard kernel config.

Hereby recommended!

The Light Be With You,
https://the-vast-x.net/Ruhban/Ruhban.html

