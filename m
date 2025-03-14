Return-Path: <linux-kernel+bounces-562083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C662A61BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D0881F09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24958221D87;
	Fri, 14 Mar 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc2UVIRP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355D21CC4B;
	Fri, 14 Mar 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982523; cv=none; b=D7u2usgNI+FiYn6QN7gHyyzEBej5qu1UNGU21Pij6oWv5QSPkh233uLtHSz4743KYheI4ClB9oVSyVFqW/vGr9YkrNJikGz9wgksTfUuHqqcdqd1RFgXHxvjnSCT3MlUs7oUzwR2dG5QyUqItGKz244k1wILCSIAI1HWcAJokr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982523; c=relaxed/simple;
	bh=vCp8QdegKIha78Nulndpn9orwEWwCD15kSIivDkMWLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxZ2ugtd6ILDQveQiI1S3nvD3neiy2bHWMrYios0USI4HcFGy2ZHlFuKitSmfpP6iyfcWBty0DXgUJxd4yyIKah5x4RICWzkQx1uECIvkFhXXM6ps1LsHBjH5sgsITtcMuSQKqXryqOfjTr2ThYE4wlP4ahQG5VYau8TVhQz2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc2UVIRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACCC4CEEE;
	Fri, 14 Mar 2025 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982523;
	bh=vCp8QdegKIha78Nulndpn9orwEWwCD15kSIivDkMWLM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yc2UVIRPxmX09FALRX5pP5YMWsN8IzonUzM8nApMvy6dM5CLHftqb0WVUVi47WxNQ
	 ewVuvxF70hZl5VvYXQT7PgdWuNT/BEPe7T1L7D31enGCejEdATcG88PZNe7s8bMxgx
	 /QOGKRcMdNkcUfOQQyAVuOjssb5+vIE8O5Tj/P0MasnW51ImQOvHZV3rmUXrG2Qhdy
	 YgIYo0DOEg2XWTOR/hLq9gg0k+0qXlxgrxKsETffJ7s6LZ/DOl1ty2X4s/UPwHaz81
	 OeZ+VeEOGRSf9Lrf8bfrd10Odab8p3HNqvsjcnWDqjxMeHmvYTbeh6GdhROgHUbI9/
	 +TLRVvvheCEbQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq5424: Enable MMC
Date: Fri, 14 Mar 2025 15:01:15 -0500
Message-ID: <174198247866.1604753.8066790177958600700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304113400.2806670-1-quic_varada@quicinc.com>
References: <20250304113400.2806670-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Mar 2025 17:04:00 +0530, Varadarajan Narayanan wrote:
> Enable MMC and relevant pinctrl entries.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq5424: Enable MMC
      commit: 1f552db1b953b737183fd7c11c4814d3d152d4cd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

